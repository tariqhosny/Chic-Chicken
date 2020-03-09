//
//  orderListCell.swift
//  Chic Chicken
//
//  Created by Tariq on 11/24/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class orderListCell: UITableViewCell {

    @IBOutlet weak var orderIdLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var orderStateLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(order: OrderData){
        orderIdLb.text = "\(order.order_id ?? 0)"
        dateLb.text = order.created_at
        priceLb.text = "\(order.order_total_price ?? "")\(helper.getCurrency() ?? "")"
        
        if Int(order.order_stat!) == 0{
            orderStateLb.text = "Order in Progress"
        }
        if Int(order.order_stat!) == 1{
            orderStateLb.text = "Order Delivered"
        }
        if Int(order.order_stat!) == 2{
            orderStateLb.text = "Order Canceled"
        }
    }

}
