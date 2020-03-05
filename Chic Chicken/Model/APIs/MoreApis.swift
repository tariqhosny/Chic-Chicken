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

    class func aboutApi(completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ about: productsModel?)-> Void){
        let parametars = [
            "lang": "en"
            ]
        Alamofire.request(URLs.about, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let about = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, about)
                }
            }catch{
                completion(false, true, nil)
            }
        }
    }
    
    class func contactUsApi(email: String, name: String, phone: String, message: String, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ contact: Messages?)-> Void){
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
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let contact = try JSONDecoder().decode(Messages.self, from: response.data!)
                    completion(false, true, contact)
                }
            }catch{
                completion(false, true, nil)
            }
        }
    }
}
