//
//  NetworkActivityDisplayable.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/7/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import Foundation
import UIKit

/// A generic enum that represents the result of network calls
enum NetworkResult<T>{
    case uninitialized
    case loading
    case success(data:T)
    case error(message:String)
}


/// The NetworkActivityDisplayable protocol provides a convenience way of showing network status to users.
/// Whenever a UIViewController class conformed to this protocol should declare:
/// - A loadingView, which is UIActivityIndicatorView type,and it can be customized in your ViewController
/// - A errorView, which is UILable type, and it can be customized in your ViewController
/// - A networkState, which is a NetworkResult<T> type
protocol NetworkActivityDisplayable {
    
    associatedtype returnedData
    
    var loadingView : UIActivityIndicatorView { get set }
    var errorView : UILabel { get }
    var networkStatus : NetworkResult<returnedData> { get set }
    
    func updateNetworkStatus()
    
}


/// This extension of NetworkActivityDisplayable makes sure that whenever a UIViewController class conformed to this protocol,
/// the implementation of required functions are therefore provided.
/// Anyone wishs to implement their custom behavior of the protocol should override these functions.
/// These functions are:
/// - A update function which updates the corresponding views according to the status of network call
/// - A setupNetworkActivityDisplayableView function that setup the loadingView and errorView in the UIViewController
/// IMPORTANT: Call this function in the viewDidLoad function, which makes sure the loadingView and errorView are layouted properly.
extension NetworkActivityDisplayable where Self : UIViewController {
    
    func setupNetworkActivityDisplayableViews(){
        
        view.addSubview(loadingView)
        
        loadingView.centerToSuperView()
        
        view.addSubview(errorView)
        
        errorView.centerToSuperView()
        errorView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
    }
    
    func updateNetworkStatus(){
        
        switch networkStatus{
            
        case .loading:
            loadingView.isHidden = false
            loadingView.startAnimating()
            errorView.isHidden = true
            
        case .success:
            loadingView.isHidden = true
            loadingView.stopAnimating()
            errorView.isHidden = true
            
        case .error(let message):
            loadingView.isHidden = true
            loadingView.stopAnimating()
            errorView.text = message
            errorView.isHidden = false
            
        case .uninitialized:
            break
        }
        
    }
    
}
