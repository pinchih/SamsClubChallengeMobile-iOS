//
//  ProductCollectionViewCell.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/7/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import UIKit
import Cosmos

class ProductCollectionViewCell:UICollectionViewCell{
    
    var productNameLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize:13)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var productImage : ProductImageView = {
        
        let imageView = ProductImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.loadingView.startAnimating()
        return imageView
        
    }()
    
    var productPriceLabel : UILabel = {
        
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red:0.99, green:0.60, blue:0.15, alpha:1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    var ratingView : CosmosView = {
        
       let view = CosmosView(frame: .zero)
       view.translatesAutoresizingMaskIntoConstraints = false
       view.settings.starSize = 13.0
       view.settings.starMargin = 1.0
       view.settings.updateOnTouch = false
       return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- helpers
extension ProductCollectionViewCell {
    
    fileprivate func setupViews(){
        
        contentView.addSubview(productImage)
        productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        productImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        productImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        productImage.widthAnchor.constraint(equalTo: productImage.heightAnchor, multiplier: 1.33).isActive = true
        
        contentView.addSubview(productNameLabel)
        productNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 0).isActive = true
        productNameLabel.leftAnchor.constraint(equalTo: productImage.leftAnchor).isActive = true
        productNameLabel.rightAnchor.constraint(equalTo: productImage.rightAnchor).isActive = true
        productNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(ratingView)
        
        productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor).isActive = true
        productPriceLabel.leftAnchor.constraint(equalTo: productNameLabel.leftAnchor).isActive = true
        productPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        productPriceLabel.widthAnchor.constraint(equalTo: ratingView.widthAnchor, multiplier: 0.5).isActive = true
        
        ratingView.centerYAnchor.constraint(equalTo: productPriceLabel.centerYAnchor).isActive = true
        ratingView.leftAnchor.constraint(equalTo: productPriceLabel.rightAnchor,constant:1).isActive = true
        ratingView.rightAnchor.constraint(equalTo: productNameLabel.rightAnchor,constant:-1).isActive = true
     
        let view = UIView()
        view.backgroundColor = .lightGray
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    fileprivate func restoreInitialViewState(){
        
        productImage.loadingView.startAnimating()
        productImage.backgroundColor = .lightGray
        productImage.image = nil
        
    }
    
}


//MARK:- Static functions
extension ProductCollectionViewCell{
    
    static func cellID()->String{
        return "ProductCollectionViewCellID"
    }
    
}

extension ProductCollectionViewCell {
    
    override func prepareForReuse() {
        
        // Restore initial state for cell reuse
        restoreInitialViewState()
        
    }
    
}
