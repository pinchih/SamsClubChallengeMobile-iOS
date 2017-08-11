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
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(red:0.99, green:0.60, blue:0.15, alpha:1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
        
    }()
    
    var ratingView : CosmosView = {
        
        let view = CosmosView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settings.starSize = 20.0
        view.settings.starMargin = 3.0
        view.settings.updateOnTouch = false
        return view
        
    }()
    
    var inStockTextLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red:0.99, green:0.60, blue:0.15, alpha:1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
        
    }()
    
    var longDescriptionLabel : WKWebView = {
       
        let configuration = WKWebViewConfiguration()
        configuration.preferences.minimumFontSize = 100
        let label = WKWebView(frame: .zero, configuration:configuration)
        //label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //label.font = UIFont.systemFont(ofSize: 10)
        //label.textColor = .lightGray
        return label
        
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
        
        scrollViewContentView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 1200)
        
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        scrollView.contentSize = CGSize(width: scrollViewContentView.frame.width, height: scrollViewContentView.frame.height)
        
        scrollView.addSubview(scrollViewContentView)
        
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
        //ratingView.rightAnchor.constraint(equalTo: productNameLabel.rightAnchor,constant:-1).isActive = true
        
        inStockTextLabel.topAnchor.constraint(equalTo: productPriceLabel.topAnchor).isActive = true
        inStockTextLabel.rightAnchor.constraint(equalTo: productNameLabel.rightAnchor,constant:-1).isActive = true
        inStockTextLabel.widthAnchor.constraint(equalTo: productPriceLabel.widthAnchor).isActive = true
        inStockTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        scrollViewContentView.addSubview(longDescriptionLabel)
        longDescriptionLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor,constant:10).isActive = true
        longDescriptionLabel.leftAnchor.constraint(equalTo: scrollViewContentView.leftAnchor,constant:10).isActive = true
        longDescriptionLabel.rightAnchor.constraint(equalTo: scrollViewContentView.rightAnchor,constant:-10).isActive = true
        longDescriptionLabel.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor,constant:-10).isActive = true
        
        
    }
    
}

//MARK:- Static functions
extension ProductDetailCollectionViewCell{
    
    static func cellID()->String{
        return "ProductCollectionViewCellID"
    }
    
}

//
extension ProductDetailCollectionViewCell {
    
    override func prepareForReuse() {
        
        // Restore initial state for cell reuse
        
        
    }
    
    
}