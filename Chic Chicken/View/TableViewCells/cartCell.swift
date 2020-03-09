//
//  cartCell.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class cartCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLb: UILabel!
    @IBOutlet weak var productPriceLb: UILabel!
    @IBOutlet weak var cartCountLb: UILabel!
    @IBOutlet weak var extraBtn: UIButton!
    
    var plus: (()->())?
    var min: (()->())?
    var delete: (()->())?
    var extra: (()->())?
    
    func configureCell(product: CartList) {
        productNameLb.text = product.product_name
        productPriceLb.text = "\(product.total_price_with_addtions ?? "")\(helper.getCurrency() ?? "")"
        cartCountLb.text = product.quantity
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(product.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        delete?()
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        min?()
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        plus?()
    }
    
    @IBAction func extraPressed(_ sender: UIButton) {
        extra?()
    }
}
