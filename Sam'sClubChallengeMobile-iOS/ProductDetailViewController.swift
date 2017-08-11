//
//  ProductDetailViewController.swift
//  Sam'sClubChallengeMobile-iOS
//
//  Created by Pin-Chih on 8/7/17.
//  Copyright © 2017 Pin-Chih Lin. All rights reserved.
//

import UIKit
import Cosmos

protocol ProductDetailViewControllerDelegate : class {
    
    func productAt(Index:Int)->Product?
    func shouldFetchProducts()
    
}

class ProductDetailViewController : UIViewController{
    
    /// A flag that indicates whether collectionView is displaying the correct cell
    var isScrolledToProductIndex = false
    
    /// Total number of products that are loaded from server
    var productCounts : Int? = 0 {
        
        didSet{
            self.collectionView.reloadData()
        }
        
    }
    
    var isFetchingProducts = false
    
    var delegate:ProductDetailViewControllerDelegate?
    
    /// A Int that represents the actual index of the product array
    var productIndex : Int?
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProductDetailCollectionViewCell.self, forCellWithReuseIdentifier: ProductDetailCollectionViewCell.cellID())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        
        return cv
        
    }()
    
    deinit {
        print("ProductDetailViewController deinit")
    }
    
}

//MARK:- VC Life cycle
extension ProductDetailViewController {
    
    override func viewDidLoad() {
        
        setupViews()
        
        setupNavigationBar()
        
        // Observe any changes in ProductViewController.products
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ProductDetailViewController.shouldUpdateProductNumber),
                                               name:.numbersOfProductsDidChanged, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        // Remove observer to prevent memory leak
        NotificationCenter.default.removeObserver(self, name: .numbersOfProductsDidChanged, object: nil)
        
    }
    
    
}

//MARK:- Helper
extension ProductDetailViewController {
    
    @objc fileprivate func shouldUpdateProductNumber(notification:Notification){
        
        guard let newCount = notification.userInfo?["productCount"] as? Int else { return }
        
        self.productCounts = newCount
        self.collectionView.reloadData()
        
    }
    
    fileprivate func setupViews(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Setup collectionView - fill superview
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant:64).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    fileprivate func setupNavigationBar(_ title:String = "Item Details" ){
        navigationItem.title = title
    }
    
    fileprivate func configure(_ cell:ProductDetailCollectionViewCell,for productIndex:Int){
        
        if let product = self.delegate?.productAt(Index:productIndex){
            
            cell.productNameLabel.text = product.name
            cell.productPriceLabel.text = product.price
            cell.ratingView.rating = Double(product.reviewRating ?? 0.0)
            cell.ratingView.text = product.reviewCount.flatMap({ return "(\($0))"})
            cell.longDescriptionLabel.loadHTMLString(product.longDescription ?? "", baseURL: nil)
            cell.inStockTextLabel.text = (product.inStock ?? false) ? ProductAvailablity.inStock.rawValue : ProductAvailablity.outOfStock.rawValue
            cell.inStockTextLabel.textColor = (product.inStock ?? false) ? UIColor(red:0.99, green:0.60, blue:0.15, alpha:1.00) : .red
            
            NetworkManger.shared.fetchImageFor(url:product.imageURL) { (result) in
                self.configureImageFetchingNetwork(result, for: cell)
            }
            
        }
        
    }
    
    fileprivate func configureImageFetchingNetwork(_ result:NetworkResult<UIImage>,for cell:ProductDetailCollectionViewCell){
        
        switch result{
        case .success(data: let data):
            cell.productImageView.image = data
            cell.productImageView.loadingView.stopAnimating()
            cell.productImageView.backgroundColor = .white
        case .error(message:_):
            cell.productImageView.loadingView.stopAnimating()
        default:
            break
        }
        
    }
}

//MARK:- UICollectionViewDelegate,UICollectionViewDataSource
extension ProductDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productCounts!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCollectionViewCell.cellID(), for: indexPath) as! ProductDetailCollectionViewCell
        
//        if indexPath.row <= productIndex!{
            configure(cell, for: indexPath.row)
//        }else{
//            configure(cell, for: productIndex! + indexPath.row)
//        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if !isScrolledToProductIndex {
            
            let indexToScrollTo = IndexPath(row: productIndex!, section: 0)
            self.collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
            isScrolledToProductIndex = true
            
        }
        
        print("Willdisplay item at index:\(indexPath.row)")
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ProductDetailCollectionViewCell{
            
            //if indexPath.row <= productIndex!{
                configure(cell, for: indexPath.row)
            //}else{
                //configure(cell, for: productIndex! + indexPath.row)
            //}
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        if indexPath.row == productCounts! - 2 {
            
            /*
            let indexPath = IndexPath(row: productCounts! - 1, section: 0)
            productCounts! += 1
            
            UIView.performWithoutAnimation {
                
                self.collectionView.insertItems(at: [indexPath])

            }
            */
            
            // Load more data
            //NotificationCenter.default.post(Notification.init(name: Notification.Name.init(rawValue: "test")))
            delegate?.shouldFetchProducts()
            
        }
 
        /*
        else if indexPath.row == 0{
            
            let indexPath = IndexPath(row:0, section: 0)
            productCounts += 1
            
            UIView.performWithoutAnimation {
                self.collectionView.insertItems(at: [indexPath])
                //                collectionView.reloadData()
            }
            
        }
        */
        //print("DidEndDisplay item at index:\(indexPath.row)")
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ProductDetailViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width , height:  collectionView.frame.height)
        
    }
    
}
