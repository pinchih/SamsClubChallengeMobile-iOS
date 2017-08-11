//
//  ProductImageView.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/8/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import UIKit

class ProductImageView: UIImageView {
    
    let loadingView : UIActivityIndicatorView = {
        
        let view = UIActivityIndicatorView()
        view.color = .white
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


// MARK:- Helper
extension ProductImageView  {
    
    fileprivate func setupViews(){
        
        addSubview(loadingView)
        loadingView.centerToSuperView()
        
    }
    
    
}
