//
//  home.swift
//  Chic Chicken
//
//  Created by Tariq on 11/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class home: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slider = [productsData]()
    var products = [productsData]()
    var timer : Timer?
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTitleImage()
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(UINib.init(nibName: "productCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        sliderHandelRefresh()
        startTimer()
        cartCounter()
    }

    override func viewWillAppear(_ animated: Bool) {
        productsHandelRefresh()
    }
    
    func sliderHandelRefresh(){
        SliderApi.sliderApi { (dataError, isSuccess, image) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let images = image{
                        self.slider = images.data!
                        self.pageControl.numberOfPages = self.slider.count
                        self.pageControl.currentPage = 0
                        //                if MOLHLanguage.currentAppleLanguage() == "ar"{
                        //                    self.slider.reverse()
                        //                }
                        self.sliderCollectionView.reloadData()
                    }
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
    func productsHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        ProductsApis.offersProductsApi { (dataError, isSuccess, product) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let product = product{
                        self.products = product.data!
                        helper.saveCurrency(token: self.products[0].currency ?? "")
                        self.productsCollectionView.reloadData()
                    }
                    print(product!)
                    self.stopAnimating()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        if currentIndex < slider.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentIndex
            currentIndex += 1
        }else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentIndex
            currentIndex = 1
        }
    }
}
extension home: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollectionView{
            return slider.count
        }else{
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
            cell.configureCell(product: products[indexPath.item], fromFavorite: 0)
            cell.addFavorite = {
                ProductsApis.addFavoriteApi(id: self.products[indexPath.item].id ?? 0) { (dataError, isSuccess, favorite) in
                    if dataError!{
                        print("data error")
                        self.stopAnimating()
                    }else{
                        if isSuccess!{
                            if favorite?.status == true{
                                if cell.isFavorite == 1{
                                    cell.isFavorite = 0
                                    cell.favoriteBtn.setImage(UIImage(named: "selected favorite"), for: .normal)
                                }else{
                                    cell.isFavorite = 1
                                    cell.favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
                                }
                            }
                        }else{
                            self.showAlert(title: "Connection", message: "Please check your internet connection")
                            self.stopAnimating()
                        }
                    }
                }
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell
            cell.configureCell(images: slider[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productsCollectionView{
            let screenWidth = collectionView.frame.width
            var width = (screenWidth-10)/2
            width = width < 130 ? 160 : width
            return CGSize.init(width: width, height: 300)
        }else{
            return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productsCollectionView{
            let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "mealDetails") as? mealDetails
            vc?.details = products[indexPath.item]
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if MOLHLanguage.currentAppleLanguage() != "ar"{
            if scrollView.tag == 1{
                currentIndex = Int(scrollView.contentOffset.x / sliderCollectionView.frame.size.width)
                pageControl.currentPage = currentIndex
            }
//        }
    }
    
}
