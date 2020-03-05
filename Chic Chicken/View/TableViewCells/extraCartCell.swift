//
//  extraCartCell.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class extraCartCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var quantityLb: UILabel!
    
    var price = Float()
    
    func configure(extra: productsData, quantity: Int){
        titleLb.text = extra.title
        quantityLb.text = "Quantity: \(quantity)"
        price = (Float(extra.price_general ?? "0") ?? 0) * Float(quantity)
        priceLb.text = "Price: \(price)\(extra.currency ?? "")"
        let urlWithOutEncoding = ("\(URLs.imageUrl)\(extra.image!)")
        let encodedLink = urlWithOutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)"){
            productImage.kf.setImage(with: url)
        }
    }

}
