//
//  OrderModel.swift
//  Chic Chicken
//
//  Created by Tariq on 3/5/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import Foundation

struct OrderModel: Codable{
    var data: [OrderData]?
    var status: Bool?
    var error: String?
}

struct OrderData: Codable{
    var order_id: Int?
    var order_total_price: String?
    var tax: Int?
    var delevery_fees: String?
    var order_stat: String?
    var customer_address: String?
    var customer_city: String?
    var customer_country: String?
    var customer_street: String?
    var langtude: String?
    var lattude: String?
    var payment_method: String?
    var payment_status: String?
    var customer_phone: String?
    var created_at: String?
}

struct OrderDetailsModel: Codable{
    var data: [OrderDetailsData]?
    var status: Bool?
    var error: String?
}

struct OrderDetailsData: Codable{
    var product_id: String?
    var image: String?
    var product_name: String?
    var product_price: String?
    var product_quantity: String?
    var product_tax: String?
}
