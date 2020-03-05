//
//  SliderModel.swift
//  Chic Chicken
//
//  Created by Tariq on 3/1/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import Foundation

struct productsModel: Codable{
    var data: [productsData]?
    var status: Bool?
    var error: String?
}

struct productsData: Codable{
    var id: Int?
    var image: String?
    var title: String?
    var size: String?
    var date: String?
    var short_description: String?
    var description: String?
    var price_general: String?
    var sale_price: String?
    var price: String?
    var Wishlist_state: Int?
    var currency: String?
}

struct addFavoriteModel: Codable{
    var data: String?
    var status: Bool?
    var error: String?
}
