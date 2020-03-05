//
//  category.swift
//  Chic Chicken
//
//  Created by Tariq on 11/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class category: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categories = [productsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        loadCategory()
        cartCounter()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func loadCategory(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        ProductsApis.categoryApi { (dataError, isSuccess, categories) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let categories = categories?.data{
                        self.categories = categories
                        self.categoryCollectionView.reloadData()
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
extension category: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
        cell.configureCell(category: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        var width = (screenWidth-5)/2
        width = width < 130 ? 160 : width
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Menu", bundle: Bundle.main).instantiateViewController(withIdentifier: "menuMeals") as? menuMeals
        vc?.category = categories[indexPath.item]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
