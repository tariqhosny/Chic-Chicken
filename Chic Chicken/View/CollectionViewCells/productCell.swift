//
//  productCell.swift
//  Chic Chicken
//
//  Created by Tariq on 11/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class productCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitleLb: UILabel!
    @IBOutlet weak var productShortDesLb: UILabel!
    @IBOutlet weak var salePriceLb: UILabel!
    @IBOutlet weak var generalPriceLb: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var addFavorite: (()->())?
    var isFavorite = 0
    
    func configureCell(product: productsData, fromFavorite: Int){
        if product.sale_price == ""{
            salePriceLb.text = "\(product.price_general ?? "")\(helper.getCurrency() ?? "")"
            priceView.isHidden = true
            generalPriceLb.isHidden = true
        }else{
            salePriceLb.text = "\(product.sale_price ?? "")\(helper.getCurrency() ?? "")"
            generalPriceLb.text = "\(product.price_general ?? "")\(helper.getCurrency() ?? "")"
        }
        if fromFavorite == 0{
            isFavorite = product.Wishlist_state ?? 0
            if isFavorite == 1{
                favoriteBtn.setImage(UIImage(named: "selected favorite"), for: .normal)
            }else{
                favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
            }
        }else{
            isFavorite = 1
            favoriteBtn.setImage(UIImage(named: "selected favorite"), for: .normal)
        }
        productTitleLb.text = product.title
        productShortDesLb.text = product.short_description
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(product.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        favoriteBtn.isEnabled = true
        favoriteBtn.isUserInteractionEnabled = true
        favoriteBtn.adjustsImageWhenHighlighted = true
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        addFavorite?()
    }
    
}
