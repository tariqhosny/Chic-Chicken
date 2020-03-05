//
//  MoreApis.swift
//  Chic Chicken
//
//  Created by Tariq on 3/2/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class MoreApis: NSObject {

    class func aboutApi(completion: @escaping(_ success: Bool?, _ about: productsModel?)-> Void){
        let parametars = [
            "lang": "en"
            ]
        Alamofire.request(URLs.about, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                case .success(let value):
                    print(value)
                    let about = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(true, about)
                }
            }catch{
                
            }
        }
    }
    
    class func contactUsApi(email: String, name: String, phone: String, message: String, completion: @escaping(_ success: Bool?, _ contact: profileMessages?)-> Void){
        let parametars = [
            "name": name,
            "email": email,
            "phone": phone,
            "message": message
            ]
        Alamofire.request(URLs.contact_message, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                case .success(let value):
                    print(value)
                    let contact = try JSONDecoder().decode(profileMessages.self, from: response.data!)
                    completion(true, contact)
                }
            }catch{
                
            }
        }
    }
}
