//
//  ProductDetailCollectionViewCell.swift
//  SamsClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/8/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import UIKit
import Cosmos
import WebKit


/// An enum that represents the availability of a product
enum ProductAvailablity:String {
    
    case inStock = "In Stock"
    case outOfStock = "Out of Stock"
    
}

//MARK:- Class properties
class ProductDetailCollectionViewCell : UICollectionViewCell{
    
    var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
        
    }()
    
    let scrollViewContentView : UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false        
        return view
        
    }()
    
    var productImageView : ProductImageView = {
        
        let imageView = ProductImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.loadingView.startAnimating()
        return imageView
        
    }()
    
    var productNameLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize:17)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var productPriceLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red:0.99, green:0.60, blue:0.15, alpha:1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
        
    }()
    
    var ratingView : CosmosView = {
        
        let view = CosmosView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settings.starSize = 18.0
        view.settings.starMargin = 2.0
        view.settings.updateOnTouch = false
        return view
        
    }()
    
    var inStockTextLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red:0.99, green:0.60, blue:0.15, alpha:1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
        
    }()
    
    var shortDescriptionTextView : UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
        
    }()
    
    var longDescriptionTextView : UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
        
    }()
    
    // init
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- Helper functions
extension ProductDetailCollectionViewCell{
    
    fileprivate func setupViews(){
        
        
        let verticalLine = UIView()
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(verticalLine)
        verticalLine.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalLine.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        verticalLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        verticalLine.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        verticalLine.backgroundColor = .lightGray
        
        
        contentView.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
        
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        scrollViewContentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        scrollViewContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContentView.widthAnchor.constraint(equalToConstant: self.contentView.frame.width).isActive = true
        
        
        scrollViewContentView.addSubview(productImageView)
        productImageView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: 10).isActive = true
        productImageView.leftAnchor.constraint(equalTo: scrollViewContentView.leftAnchor, constant: 10).isActive = true
        productImageView.rightAnchor.constraint(equalTo: scrollViewContentView.rightAnchor, constant: -10).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor, multiplier: 1.33).isActive = true
        
        scrollViewContentView.addSubview(productNameLabel)
        productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10).isActive = true
        productNameLabel.leftAnchor.constraint(equalTo: productImageView.leftAnchor).isActive = true
        productNameLabel.rightAnchor.constraint(equalTo: productImageView.rightAnchor).isActive = true
        productNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        scrollViewContentView.addSubview(productPriceLabel)
        scrollViewContentView.addSubview(ratingView)
        scrollViewContentView.addSubview(inStockTextLabel)
        
        productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor).isActive = true
        productPriceLabel.leftAnchor.constraint(equalTo: productNameLabel.leftAnchor).isActive = true
        productPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        productPriceLabel.widthAnchor.constraint(equalTo: inStockTextLabel.widthAnchor).isActive = true
        
        ratingView.centerYAnchor.constraint(equalTo: productPriceLabel.centerYAnchor).isActive = true
        ratingView.leftAnchor.constraint(equalTo: productPriceLabel.rightAnchor,constant:1).isActive = true
        ratingView.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor).isActive = true
        ratingView.widthAnchor.constraint(lessThanOrEqualToConstant: 130).isActive = true
        
        
        inStockTextLabel.topAnchor.constraint(equalTo: productPriceLabel.topAnchor).isActive = true
        inStockTextLabel.rightAnchor.constraint(equalTo: productNameLabel.rightAnchor,constant:-1).isActive = true
        inStockTextLabel.widthAnchor.constraint(equalTo: productPriceLabel.widthAnchor).isActive = true
        inStockTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        scrollViewContentView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leftAnchor.constraint(equalTo: scrollViewContentView.leftAnchor,constant:10).isActive = true
        separator.rightAnchor.constraint(equalTo: scrollViewContentView.rightAnchor,constant:-10).isActive = true
        separator.topAnchor.constraint(equalTo: inStockTextLabel.bottomAnchor,constant:10).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        
        scrollViewContentView.addSubview(shortDescriptionTextView)
        shortDescriptionTextView.topAnchor.constraint(equalTo: separator.bottomAnchor,constant:10).isActive = true
        shortDescriptionTextView.leftAnchor.constraint(equalTo: scrollViewContentView.leftAnchor,constant:10).isActive = true
        shortDescriptionTextView.rightAnchor.constraint(equalTo: scrollViewContentView.rightAnchor,constant:-10).isActive = true        
        
        let separator2 = UIView()
        separator2.backgroundColor = .lightGray
        scrollViewContentView.addSubview(separator2)
        separator2.translatesAutoresizingMaskIntoConstraints = false
        separator2.leftAnchor.constraint(equalTo: scrollViewContentView.leftAnchor,constant:10).isActive = true
        separator2.rightAnchor.constraint(equalTo: scrollViewContentView.rightAnchor,constant:-10).isActive = true
        separator2.topAnchor.constraint(equalTo: shortDescriptionTextView.bottomAnchor).isActive = true
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        scrollViewContentView.addSubview(longDescriptionTextView)
        longDescriptionTextView.topAnchor.constraint(equalTo: shortDescriptionTextView.bottomAnchor,constant:10).isActive = true
        longDescriptionTextView.leftAnchor.constraint(equalTo: scrollViewContentView.leftAnchor,constant:10).isActive = true
        longDescriptionTextView.rightAnchor.constraint(equalTo: scrollViewContentView.rightAnchor,constant:-10).isActive = true
        longDescriptionTextView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor,constant:-10).isActive = true
        
        
    }
    
}

//MARK:- Static functions
extension ProductDetailCollectionViewCell{
    
    static func cellID()->String{
        return "ProductCollectionViewCellID"
    }
    
}

