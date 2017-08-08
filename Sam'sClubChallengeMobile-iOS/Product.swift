//
//  Product.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/7/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import Foundation


class Product:NSObject{
    
    /*
    productId : Unique Id of the product
    productName : Product Name
    shortDescription : Short Description of the product
    longDescription : Long Description of the product
    price : Product price
    productImage : Image url for the product
    reviewRating : Average review rating for the product
    reviewCount : Number of reviews
    inStock : Returns true if item in stock
    */
    
    var id : String?
    var name : String?
    var shortDescription : String?
    var longDescription : String?
    var price : String?
    var imageURL : URL?
    var reviewRating : Float?
    var reviewCount : UInt?
    var inStock : Bool?
    
    convenience init(id:String,name:String,shortDescription:String,longDescription:String,price:String,imageURLString:String,rating:Float,count:UInt,inStock:Bool){
        
        self.init()
        
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.price = price
        
        if let url = URL(string: imageURLString){
            self.imageURL = url
        }
        
        self.reviewRating = rating
        self.reviewCount = count
        self.inStock = inStock
        
    }
    
}
