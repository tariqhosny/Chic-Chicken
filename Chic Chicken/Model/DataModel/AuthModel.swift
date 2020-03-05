//
//  AuthModel.swift
//  Chic Chicken
//
//  Created by Tariq on 3/1/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import Foundation

struct AuthModel: Codable{
    var data: AuthData?
    var status: Bool?
}

struct AuthData: Codable {
    var user_token: String?
    var name: String?
    var email: String?
    var phone: String?
    
    enum CodingKeys: String, CodingKey {
        case user_token = "user_token "
        case name, email, phone
    }
}

struct userData: Codable{
    var data: [AuthData]?
    var status: Bool?
    var error: String?
}

struct Messages: Codable{
    var data: String?
    var status: Bool?
    var message: String?
    var errors: AuthError?
}

struct AuthError: Codable {
    var email: [String]?
}
