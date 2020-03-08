//
//  mealDetails.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class mealDetails: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var sizesCollectionView: UICollectionView!
    @IBOutlet weak var includesTableView: UITableView!
    @IBOutlet weak var mealDescription: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var mealNameLb: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var salePriceLb: UILabel!
    @IBOutlet weak var generalPriceLb: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var quantityLb: UILabel!
    
    var tableheight = CGFloat()
    var images = [productsData]()
    var details = productsData()
    var sizes = [productsData]()
    var exteras = [productsData]()
    var sizeId = Int()
    var extraIDs = [Int]()
    var extraIdsString = String()
    var price = Float()
    var extraPrice = Float()
    var totalPrice = Float()
    var quantity = 1
    var isFavorite = 0
    var fromFavorite = 0
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
        addTitleImage()
        loadSizes()
        loadExtaras()
        sliderHandelRefresh()
        cartCounter()
        
        includesTableView.delegate = self
        includesTableView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        sizesCollectionView.delegate = self
        sizesCollectionView.dataSource = self
        includesTableView.allowsMultipleSelection = true
        includesTableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func fillData(){
        mealNameLb.text = details.title
        mealDescription.text = details.description
        if fromFavorite == 0{
            isFavorite = details.Wishlist_state ?? 0
            if isFavorite == 1{
                favoriteBtn.setImage(UIImage(named: "selected favorite"), for: .normal)
            }else{
                favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
            }
        }else{
            isFavorite = 1
            favoriteBtn.setImage(UIImage(named: "selected favorite"), for: .normal)
        }
    }
    
    func sliderHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        ProductsApis.productImagesApi(id: details.id ?? 0) { (dataError, isSuccess, image) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let images = image?.data{
                        self.images = images
                        //                if MOLHLanguage.currentAppleLanguage() == "ar"{
                        //                    self.slider.reverse()
                        //                }
                        self.imageCollectionView.reloadData()
                    }
                    self.stopAnimating()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
    func loadSizes(){
        ProductsApis.productSizesApi(id: details.id ?? 0) { (dataError, isSuccess, sizes) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let sizes = sizes?.data{
                        self.sizes = sizes
                        self.sizesCollectionView.reloadData()
                        self.sizesCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
                        self.sizeId = self.sizes[0].id ?? 0
                        if self.sizes[0].sale_price == ""{
                            self.price = Float(self.sizes[0].price ?? "0") ?? 0
                            self.totalPrice = self.price + self.extraPrice
                            self.salePriceLb.text = "\(self.sizes[0].price ?? "")\(helper.getCurrency() ?? "")"
                            self.priceView.isHidden = true
                            self.generalPriceLb.isHidden = true
                        }else{
                            self.salePriceLb.text = "\(self.sizes[0].sale_price ?? "")\(helper.getCurrency() ?? "")"
                            self.generalPriceLb.text = "\(self.sizes[0].price ?? "")\(helper.getCurrency() ?? "")"
                            self.price = Float(self.sizes[0].sale_price ?? "0") ?? 0
                            self.totalPrice = self.price + self.extraPrice
                        }
                    }
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
    func loadExtaras(){
        ProductsApis.productExtrasApi(id: details.id ?? 0) { (dataError, isSuccess, exteras) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let exteras = exteras?.data{
                        self.exteras = exteras
                        self.includesTableView.reloadData()
                    }
                    self.includesTableView.reloadData()
                    self.tableheight = CGFloat(self.exteras.count * 60)
                    self.viewHeight.constant = self.tableheight + self.mealDescription.frame.size.height + (self.mealDescription.frame.size.height) + 500
                    self.view.layoutIfNeeded()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        ProductsApis.addFavoriteApi(id: details.id ?? 0) { (dataError, isSuccess, favorite) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if favorite?.status == true{
                        if self.isFavorite == 1{
                            self.isFavorite = 0
                            self.favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
                        }else{
                            self.isFavorite = 1
                            self.favoriteBtn.setImage(UIImage(named: "selected favorite"), for: .normal)
                        }
                    }
                    self.stopAnimating()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        quantity += 1
        quantityLb.text = "\(quantity)"
        self.salePriceLb.text = "\(self.totalPrice * Float(quantity))\(helper.getCurrency() ?? "")"
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        if quantity > 1{
            quantity -= 1
            quantityLb.text = "\(quantity)"
            self.salePriceLb.text = "\(self.totalPrice * Float(quantity))\(helper.getCurrency() ?? "")"
        }
    }
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        var extra = String()
        self.extraIdsString = ""
        if extraIDs.count == 0{
            extra = ""
        }else{
            for item in 0...extraIDs.count - 1{
                self.extraIdsString.append(contentsOf: "\(extraIDs[item]),")
            }
            extra = String(extraIdsString.dropLast())
        }
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        OrderApis.addCartApi(id: details.id ?? 0, quantity: quantity, sizeId: sizeId, additionId: extra) { (dataError, isSuccess, cart) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let cart = cart?.data{
                        self.showAlert(title: "Cart", message: cart)
                        self.cartCounter()
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
extension mealDetails: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sizesCollectionView{
            return sizes.count
        }else{
           return images.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sizesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sizesCell", for: indexPath) as! sizesCell
            cell.configureCell(sizes: sizes[indexPath.item])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell
            cell.configureCell(images: images[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sizesCollectionView{
            self.sizeId = self.sizes[indexPath.item].id ?? 0
            if self.sizes[indexPath.item].sale_price == ""{
                self.price = Float(self.sizes[indexPath.item].price ?? "0") ?? 0
                self.totalPrice = price + extraPrice
                self.salePriceLb.text = "\(self.totalPrice * Float(quantity))\(helper.getCurrency() ?? "")"
                self.priceView.isHidden = true
                self.generalPriceLb.isHidden = true
            }else{
                self.price = Float(self.sizes[indexPath.item].sale_price ?? "0") ?? 0
                self.totalPrice = price + extraPrice
                self.salePriceLb.text = "\(self.totalPrice * Float(quantity))\(helper.getCurrency() ?? "")"
                self.generalPriceLb.text = "\(self.sizes[indexPath.item].price ?? "")\(helper.getCurrency() ?? "")"
            }
        }else{
            if images.count != 0{
                //imageViewer
                self.index = indexPath.item
                let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "imageViewer") as? ImageViewer
                vc?.image = images
                vc?.index = index
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sizesCollectionView{
            return CGSize.init(width: 100, height: 60)
        }else{
           return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == sizesCollectionView {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
                let dataSourceCount = sizesCollectionView.dataSource?.collectionView(sizesCollectionView, numberOfItemsInSection: section),
                dataSourceCount > 0 else {
                    return .zero
            }
            let cellCount = CGFloat(dataSourceCount)
            let itemSpacing = flowLayout.minimumInteritemSpacing
            let cellWidth = flowLayout.itemSize.width + itemSpacing
            var insets = flowLayout.sectionInset
            
            let totalCellWidth = (cellWidth * cellCount) - itemSpacing
            let contentWidth = sizesCollectionView.frame.size.width - sizesCollectionView.contentInset.left - sizesCollectionView.contentInset.right

            guard totalCellWidth < contentWidth else {
                return insets
            }
            let padding = (contentWidth - totalCellWidth) / 2.0
            insets.left = padding
            insets.right = padding
            return insets
        }
        else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
}

extension mealDetails: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exteras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "includesCell", for: indexPath) as! includesCell
        cell.selectionStyle = .none
        cell.configure(extra: exteras[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !extraIDs.contains(exteras[indexPath.row].id ?? 0){
            extraIDs.append(exteras[indexPath.row].id ?? 0)
            extraPrice += Float(exteras[indexPath.row].price_general ?? "0") ?? 0
            self.totalPrice = price + extraPrice
            self.salePriceLb.text = "\(self.totalPrice * Float(quantity))\(helper.getCurrency() ?? "")"
        }
        print(extraIDs)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var currentIndex = 0
        for id in extraIDs{
            if id == exteras[indexPath.row].id {
                extraIDs.remove(at: currentIndex)
                extraPrice -= Float(exteras[indexPath.row].price_general ?? "0") ?? 0
                self.totalPrice = price + extraPrice
                self.salePriceLb.text = "\(self.totalPrice * Float(quantity))\(helper.getCurrency() ?? "")"
                break
            }
            currentIndex += 1
        }
        print(extraIDs)
    }
}
