//
//  AppDelegate.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/7/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?

}


//MARK:- UIApplicationDelegate
extension AppDelegate : UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                
        setupNavigationBarApperacne()
        
        // Create new UIWindow
        window = UIWindow()
        
        // Assign rootViewController to the window
        window?.rootViewController = UINavigationController(rootViewController: ProductViewController(withPageSize:30))
        
        // Make window visible
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

//MARK:- Helper
extension AppDelegate {
    
    fileprivate func setupNavigationBarApperacne(){
        
        // Change the look of Navi. bar
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
        UINavigationBar.appearance().barTintColor = Color.navigationBarTintColor
        UINavigationBar.appearance().tintColor = .white
        
    }
}

