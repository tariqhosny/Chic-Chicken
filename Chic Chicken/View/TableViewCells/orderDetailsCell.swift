//
//  orderDetailsCell.swift
//  Chic Chicken
//
//  Created by Tariq on 11/24/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class orderDetailsCell: UITableViewCell {

    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderNameLb: UILabel!
    @IBOutlet weak var countLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    
    var extra: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(order: OrderDetailsData) {
        orderNameLb.text = order.product_name
        priceLb.text = "Price: \(order.product_price ?? "")"
        countLb.text = "Quantity: \(order.product_quantity ?? "")"
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(order.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        orderImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            orderImage.kf.setImage(with: url)
        }
    }
    
    @IBAction func extraPressed(_ sender: UIButton) {
        extra?()
    }
    
}
