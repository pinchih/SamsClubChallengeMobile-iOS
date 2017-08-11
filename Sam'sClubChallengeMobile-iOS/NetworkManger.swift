//
//  NetworkManger.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/7/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import Foundation
import UIKit


/// A enum that represents the key in the returned product json object
enum ProductAttributeKey : String {
    
    case id = "id"
    case name = "productName"
    case shortDescription = "shortDescription"
    case longDescription = "longDescription"
    case price = "price"
    case image = "productImage"
    case rating = "reviewRating"
    case count = "reviewCount"
    case inStock = "inStock"
    case products = "products"
}

/// A enum that represents the key in the returned product json object
enum NetworkAttributeKey : String {
    
    case status = "status"
    
}


class NetworkManger: NSObject {
    
    /// A singleton object
    static let shared = NetworkManger()
    
    /// A string that contains the APi key
    fileprivate let apiKey = "7837b28e-e381-4186-9a87-70ba25c4c68c"
    
    /// A string that contains the API URL
    fileprivate let apiURLString = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/walmartproducts/"
    
    /// A NSCache object to cache image
    var imageCache = NSCache<NSURL, UIImage>()
    
}

// MARK:- public functions
extension NetworkManger{
    
    /// This function fetch product data from the server
    ///
    /// - Parameters:
    ///   - number: The number of the page
    ///   - size: The size of the page
    ///   - completion: A callback that takes a NetworkResult<[Product]> as an input
    public func fetchProductsForPage(number:Int,size:Int,completion:@escaping(NetworkResult<[Product]>)->()){
        
        guard let url = URL.init(string: "\(apiURLString)\(apiKey)/\(number)/\(size)") else {
            return
        }
        
        
//        let jsonURL = Bundle.main.url(forResource: "sample", withExtension: "json")!
//        
//        let jsonData = try! Data.init(contentsOf: jsonURL)
//        
//        
//        DispatchQueue.main.async {
//            
//            completion(self.parseJSON(jsonData))
//            
//        }
        

        let task = URLSession.shared.dataTask(with:url) { (data, response, error) in
         
            if let e = error {
         
                print("Error : \(e.localizedDescription)")
                
                DispatchQueue.main.async {
                    completion(NetworkResult<[Product]>.error(message:e.localizedDescription))
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completion(self.parseJSON(data))
            }
            
            
        }
 
        task.resume()
        
        
    }
    
    
    /// This function fetch product image for given url
    ///
    /// - Parameters:
    ///   - url: A url object that represents the image location
    ///   - completion: A callback that takes a NetworkResult<[UIImage]> as an input
    public func fetchImageFor(url:URL?,completion:@escaping(NetworkResult<UIImage>)->()){
        
        guard let url = url else { return }
        
        if let image = imageCache.object(forKey: url as NSURL){
            completion(NetworkResult<UIImage>.success(data: image))
            return
        }
        
        let taskConfiguration = URLSessionConfiguration.default
        
        let taskSession = URLSession(configuration: taskConfiguration)
        
        let task = taskSession.dataTask(with: url) { (data, response, error) in
            
            if let e = error {
                
                print(e.localizedDescription)
                
                DispatchQueue.main.async {
                    completion(NetworkResult<UIImage>.error(message: ""))
                }
                
            }else{
                
                if let d = data, let image = UIImage.init(data: d) {
                    
                    self.imageCache.setObject(image, forKey: url as NSURL)
                    
                    DispatchQueue.main.async {
                        completion(NetworkResult<UIImage>.success(data: image))
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
}


//MARK:- Helper
extension NetworkManger {
    
    
    /// This function takes an array of Dictionary object and covert it to an array of Product objects
    ///
    /// - Parameter productDictionaries: An array of Dictionary object
    /// - Returns: An array of Product objects
    fileprivate func covert(_ productDictionaries:[[String:AnyObject]])->[Product]{
        
        var products = [Product]()
        
        productDictionaries.forEach({ (productDictionary) in
            
            let product = Product(id: productDictionary[ProductAttributeKey.id.rawValue] as? String,
                                  name: productDictionary[ProductAttributeKey.name.rawValue] as? String,
                                  shortDescription: productDictionary[ProductAttributeKey.shortDescription.rawValue] as? String,
                                  longDescription: productDictionary[ProductAttributeKey.longDescription.rawValue] as? String,
                                  price: productDictionary[ProductAttributeKey.price.rawValue] as? String,
                                  imageURLString: productDictionary[ProductAttributeKey.image.rawValue] as? String,
                                  rating: productDictionary[ProductAttributeKey.rating.rawValue] as? Float,
                                  count: productDictionary[ProductAttributeKey.count.rawValue] as? UInt,
                                  inStock: productDictionary[ProductAttributeKey.inStock.rawValue] as? Bool)
            
            products.append(product)
            
        })
        
        return products
    }
    
    
    fileprivate func parseJSON(_ Data:Data?)->NetworkResult<[Product]>{
        
        guard let d = Data else {
            return NetworkResult<[Product]>.error(message:"Something went wrong, please try again later")
        }
        
        
        do {
            
            guard let jsonObject = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject] else {
                
                print("error trying to convert data to JSON")
                
                return NetworkResult<[Product]>.error(message:"Something went wrong, please try again later")
                
            }
            
            guard let status = jsonObject[NetworkAttributeKey.status.rawValue] as? Int, status == 200 else {
                
                print("Network error")
                
                return NetworkResult<[Product]>.error(message:"Something went wrong, please try again later")
              
                
                
            }
            
            if let productDictionaries = jsonObject[ProductAttributeKey.products.rawValue] as? [[String:AnyObject]] {
                
                let products = self.covert(productDictionaries)
                
                return NetworkResult<[Product]>.success(data:products)
                
                
            }
            
        } catch  {
            
            print("error trying to convert data to JSON")
            
           return NetworkResult<[Product]>.error(message:"Something went wrong, please try again later")
           
        }
        
        return NetworkResult<[Product]>.error(message:"Something went wrong, please try again later")
        
    }
    
}
