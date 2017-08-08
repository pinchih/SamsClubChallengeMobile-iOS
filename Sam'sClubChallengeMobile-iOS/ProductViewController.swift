//
//  ProductViewController.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/7/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import UIKit

class ProductViewController : UIViewController{
    
    // NetworkActivityDisplayable
    typealias returnedData = [Product]
    
    var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    var errorView: UILabel = {
        let view = UILabel()
        return view
    }()
    
    var networkStatus: NetworkResult<[Product]> = NetworkResult<[Product]>.uninitialized
    
    
    // Other views
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
        
    }()
    
    
}

//MARK:- VC life cycle
extension ProductViewController{
    
    override func viewDidLoad() {
        
        setupViews()
        
    }
    
    
}

//MARK:- Helper
extension ProductViewController{
    
    fileprivate func setupViews(){
        
        // Setup NetworkActivityDisplayableView
        setupNetworkActivityDisplayableView()
        
        // Setup collectionView
        
        
    }
    
    
}

//MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension ProductViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ProductViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 50)
        
    }
    
}

//MARK:- NetworkActivityDisplayable
extension ProductViewController :NetworkActivityDisplayable{
    
}


