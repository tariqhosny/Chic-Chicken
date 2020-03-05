//
//  AuthApi.swift
//  Chic Chicken
//
//  Created by Tariq on 3/1/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class AuthApi: NSObject {

    class func registerApi(name: String, email: String, phone: String, password: String, completion: @escaping(_ success: Bool?, _ userData: AuthModel?)-> Void){
        let parametars = [
            "name": name,
            "email": email,
            "phone": phone,
            "password": password
        ]
        Alamofire.request(URLs.register, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                case .success(let value):
                    print(value)
                    let register = try JSONDecoder().decode(AuthModel.self, from: response.data!)
                    print(register)
                    completion(true, register)
                }
            }catch{
                
            }
        }
    }
    
    class func loginApi(email: String, password: String, completion: @escaping(_ success: Bool?, _ userData: AuthModel?)-> Void){
        let parameters = [
            "email": email,
            "password": password
        ]
        Alamofire.request(URLs.login, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                case .success(let value):
                    print(value)
                    let login = try JSONDecoder().decode(AuthModel.self, from: response.data!)
                    print(login)
                    completion(true, login)
                }
            }catch{
                
            }
        }
    }
    
    class func userDataApi(completion: @escaping(_ success: Bool?, _ userData: userData?)-> Void){
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.profile, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                case .success(let value):
                    print(value)
                    let user = try JSONDecoder().decode(userData.self, from: response.data!)
                    print(user)
                    completion(true, user)
                }
            }catch{
                
            }
        }
    }
    
    class func updateProfileApi(email: String, name: String, phone: String, completion: @escaping(_ success: Bool?, _ messages: Messages?)-> Void){
        let parameters = [
            "email": email,
            "name": name,
            "phone": phone
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.updateProfile, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                case .success(let value):
                    print(value)
                    let messages = try JSONDecoder().decode(Messages.self, from: response.data!)
                    print(messages)
                    completion(true, messages)
                }
            }catch{
                
            }
        }
    }
    
    class func updatePasswordApi(password: String, newPassword: String, completion: @escaping(_ success: Bool?, _ message: Messages?)-> Void){
        let parametars = [
            "password": password,
            "new_password": newPassword
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.change_password, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                case .success(let value):
                    print(value)
                    let message = try JSONDecoder().decode(Messages.self, from: response.data!)
                    completion(true, message)
                }
            }catch{
                
            }
        }
    }
    
}
