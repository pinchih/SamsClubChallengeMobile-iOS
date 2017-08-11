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
        view.color = .lightGray
        return view
    }()
    
    var errorView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.textColor = .lightGray
        return view
    }()
    
    var networkStatus: NetworkResult<[Product]> = NetworkResult<[Product]>.uninitialized{
        
        didSet {
            updateNetworkStatus()
        }
        
    }
    
    var isFetchingProducts = false
    
    // Other views
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.cellID())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        return cv
        
    }()
    
    // Attributes
    var currentPageNumber : Int = 1
    
    var pageSize : Int = 0
    
    var products = [Product](){
        
        didSet{
            NotificationCenter.default.post(name:.numbersOfProductsDidChanged, object: nil, userInfo: ["productCount":products.count])
        }
        
    }
    
}


//MARK:- VC life cycle
extension ProductViewController{
    
    override func viewDidLoad() {
        
        setupViews()
        
        fetchProducts(withLoadingViewPresented:true)
        
    }
    
    convenience init(withPageSize pageSize:Int){
        self.init(nibName: nil, bundle: nil)
        self.pageSize = pageSize
    }
    
}

//MARK:- Helper functions
extension ProductViewController{
    
    fileprivate func setupViews(){
        
        view.backgroundColor = .white
        
        // Setup collectionView - fill superview
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Setup NetworkActivityDisplayableViews
        setupNetworkActivityDisplayableViews()
        
        setupNavigationBar()
        
        
    }
    
    fileprivate func setupNavigationBar(){
        navigationItem.title = "WalmartLab"
    }
    
    @objc fileprivate func test(){
        
        isFetchingProducts = true
        
        currentPageNumber += 1
        
        NetworkManger.shared.fetchProductsForPage(number: currentPageNumber, size: pageSize) { (result) in
            self.configureNetworkResult(result)
            self.isFetchingProducts = false
            
        }
        
    }
    
    fileprivate func fetchProducts(withLoadingViewPresented:Bool){
        
        
        if withLoadingViewPresented {
            networkStatus = NetworkResult<[Product]>.loading
        }
        
        isFetchingProducts = true
        
        currentPageNumber += 1
        
        NetworkManger.shared.fetchProductsForPage(number: currentPageNumber, size: pageSize) { (result) in
            self.configureNetworkResult(result)
            self.isFetchingProducts = false
        }

        
    }
    
    fileprivate func configureNetworkResult(_ result:NetworkResult<[Product]>){
        
        switch result{
        case .success(data: let data):
            
            self.products.append(contentsOf: data)
            self.collectionView.reloadData()
            self.networkStatus = NetworkResult<[Product]>.success(data:data)
            
        case .error(message:let message):
            self.networkStatus = NetworkResult<[Product]>.error(message: message)
            
        default:
            break
        }
        
    }
    
    fileprivate func configureImageFetchingNetwork(_ result:NetworkResult<UIImage>,for cell:ProductCollectionViewCell){
        
        switch result{
            
        case .success(data: let data):
            cell.productImage.image = data
            cell.productImage.loadingView.stopAnimating()
            cell.productImage.backgroundColor = .white
        case .error(message:_):
            cell.productImage.loadingView.stopAnimating()
        default:
            break
            
        }
        
    }
    
    fileprivate func configure(_ cell: ProductCollectionViewCell, for indexPath:IndexPath){
        
        let product = products[indexPath.row]
        
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = product.price
        cell.ratingView.rating = Double(product.reviewRating ?? 0.0)
        cell.ratingView.text = product.reviewCount.flatMap({ return "(\($0))"})
        
        NetworkManger.shared.fetchImageFor(url:product.imageURL) { (result) in
            self.configureImageFetchingNetwork(result, for: cell)
        }
        
    }
    
}

//MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension ProductViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellID(), for: indexPath) as! ProductCollectionViewCell
        
        // Prepare cell to display
        configure(cell, for:indexPath)
        
        // If this cell is the last cell and we're not currently fetching any data, load more data from the server
        if indexPath.row == products.count - 1 && isFetchingProducts == false {
            print("[DEBUG] Current page number : \(currentPageNumber)")
            fetchProducts(withLoadingViewPresented:false)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ProductDetailViewController()
        vc.delegate = self
        vc.productCounts = products.count
        vc.productIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ProductViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/2 , height: (self.view.frame.width/2)*1.2 )
        
    }
    
}

//MARK:- NetworkActivityDisplayable
extension ProductViewController :NetworkActivityDisplayable{
    
}

//MARK:- ProductDetailViewControllerDelegate
extension ProductViewController :ProductDetailViewControllerDelegate{
    
    func productAt(Index: Int) -> Product? {
        
        if Index < products.count {
            
            //print("Index:\(Index)")
            
            return products[Index]
            
        }else{
            
            // Load more data
            print("Load more data...")
            fetchProducts(withLoadingViewPresented: false)
            
            return nil
        }
        
    }
 
    func shouldFetchProducts() {
        
        test()
        
    }
}



