//
//  MoreApis.swift
//  Chic Chicken
//
//  Created by Tariq on 3/2/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class OrderApis: NSObject {
    
    class func addCartApi(id: Int, quantity: Int, sizeId: Int, additionId: String, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ cart: Messages?)-> Void){
        let parametars = [
            "product_id": id,
            "product_quantity": quantity,
            "size_id": sizeId,
            "addition_id": additionId
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        print(parametars)
        Alamofire.request(URLs.addCart, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let cart = try JSONDecoder().decode(Messages.self, from: response.data!)
                    completion(false, true, cart)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func listCartApi(completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ cart: CartModel?)-> Void){
        let parametars = [
            "lang": "en"
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.cartList, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let cart = try JSONDecoder().decode(CartModel.self, from: response.data!)
                    print(cart)
                    completion(false, true, cart)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func cartApi(url: String, id: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ cart: Messages?)-> Void){
        let parametars = [
            "lang": "en",
            "cart_id": id
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let Message = try JSONDecoder().decode(Messages.self, from: response.data!)
                    print(Message)
                    completion(false, true, Message)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func extraCartApi(id: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ extra: productsModel?)-> Void){
        let parametars = [
            "lang": "en",
            "cart_id": id
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.extraCart, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let extra = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, extra)
                }
            }catch{
                completion(false, true, nil)
            }
        }
    }
    
    class func createOrderApi(price: String, phone: String, paymentMethod: Int, paymentStatus: Int, city: String, country: String, street: String, floorNumber: String, homeNumber: String, region: String, lat: Double, long: Double, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ message: Messages?)-> Void){
        let parametars = [
            "order_total_price": Float(price)!,
            "customer_address": "Address",
            "customer_phone": phone,
            "payment_method": paymentMethod,
            "langtude": long,
            "lattude": lat,
            "payment_status": paymentStatus,
            "customer_city": city,
            "customer_country": country,
            "customer_street": street,
            "customer_floor_number": floorNumber,
            "customer_home_number": homeNumber,
            "customer_region": region
            ] as [String : Any]
        print(parametars)
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.createOrder, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let message = try JSONDecoder().decode(Messages.self, from: response.data!)
                    completion(false, true, message)
                }
            }catch{
                completion(false, true, nil)
            }
        }
    }
    
    class func listOrderApi(completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ order: OrderModel?)-> Void){
        let parametars = [
            "lang": "en"
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.orderList, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let order = try JSONDecoder().decode(OrderModel.self, from: response.data!)
                    completion(false, true, order)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func listOrderDetailsApi(id: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ order: OrderDetailsModel?)-> Void){
        let parametars = [
            "lang": "en",
            "order_id": id
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.order_list_details, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let order = try JSONDecoder().decode(OrderDetailsModel.self, from: response.data!)
                    completion(false, true, order)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func listOrderExtraApi(orderId: Int, productId: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ extra: productsModel?)-> Void){
        let parametars = [
            "lang": "en",
            "order_id": orderId,
            "product_id": productId
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.orderExtra, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let extra = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, extra)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
}
