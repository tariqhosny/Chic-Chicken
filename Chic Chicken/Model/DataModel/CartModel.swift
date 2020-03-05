//
//  CartModel.swift
//  Chic Chicken
//
//  Created by Tariq on 3/4/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import Foundation

struct CartModel: Codable{
    var data: CartData?
    var status: Bool?
    var error: String?
}

struct CartData: Codable{
    var list: [CartList]?
    var total_tax: Int?
    var total_delevery_fees: String?
    var price: Int?
}

struct CartList: Codable{
    var cart_id: Int?
    var product_id: String?
    var image: String?
    var product_name: String?
    var size: String?
    var quantity: String?
    var short_description: String?
    var description: String?
    var unit_price: String?
    var total_price_with_addtions: String?
    var currency: String?
    var total_unit_price: Int?
}
