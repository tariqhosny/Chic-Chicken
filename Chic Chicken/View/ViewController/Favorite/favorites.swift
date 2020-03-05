//
//  favorites.swift
//  Chic Chicken
//
//  Created by Tariq on 11/20/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class favorites: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var products = [productsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        cartCounter()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        favoriteCollectionView.register(UINib.init(nibName: "productCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        laodFavorites()
    }
    
    func laodFavorites(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        ProductsApis.favoriteListApi { (dataError, isSuccess, products)  in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let products = products?.data{
                        self.products = products
                        self.favoriteCollectionView.reloadData()
                    }
                    self.stopAnimating()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }

}
extension favorites: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
        cell.configureCell(product: products[indexPath.item], fromFavorite: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "mealDetails") as! mealDetails
        vc.fromFavorite = 1
        vc.details = products[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        var width = (screenWidth-5)/2
        width = width < 130 ? 160 : width
        return CGSize.init(width: width, height: 300)
    }
}
