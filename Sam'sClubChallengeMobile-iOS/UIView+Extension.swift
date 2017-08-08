//
//  UIView+Extension.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/7/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import UIKit


extension UIView{
    
    
    public func centerXToSuperView(){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: 0).isActive = true
        }
        
    }
    
    public func centerYToSuperView(){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: 0).isActive = true
        }
        
    }
    
    func centerToSuperView(){
        
        centerXToSuperView()
        centerYToSuperView()
        
    }
    
    
}
