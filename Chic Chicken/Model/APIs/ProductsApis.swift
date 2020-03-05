//
//  ProductsApis.swift
//  Chic Chicken
//
//  Created by Tariq on 3/1/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class ProductsApis: NSObject {

    class func offersProductsApi(completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ offers: productsModel?)-> Void){
        let parametars = [
            "lang": "en"
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.offers_products, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let offers = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, offers)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func productImagesApi(id: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ images: productsModel?)-> Void){
        let parametars = [
            "lang": "en",
            "product_id": id
            ] as [String : Any]
        Alamofire.request(URLs.productImages, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let images = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, images)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func addFavoriteApi(id: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ favorite: addFavoriteModel?)-> Void){
        let parametars = [
            "lang": "en",
            "product_id": id
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.favorite, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let favorite = try JSONDecoder().decode(addFavoriteModel.self, from: response.data!)
                    completion(false, true, favorite)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func favoriteListApi(completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ favorite: productsModel?)-> Void){
        let parametars = [
            "lang": "en"
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.favoriteList, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let favorite = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, favorite)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func categoryApi(completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ category: productsModel?)-> Void){
        let parametars = [
            "lang": "en"
            ]
        Alamofire.request(URLs.categories, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let category = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, category)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func categoryMealApi(id: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ meals: productsModel?)-> Void){
        let parametars = [
            "lang": "en",
            "category_id": id
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.products_category, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let meals = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, meals)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func productSizesApi(id: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ sizes: productsModel?)-> Void){
        let parametars = [
            "lang": "en",
            "product_id": id
            ] as [String : Any]
        Alamofire.request(URLs.sizes, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                switch response.result
                {
                case .failure(let error):
                    print(error)
                    completion(false, false, nil)
                case .success(let value):
                    print(value)
                    let sizes = try JSONDecoder().decode(productsModel.self, from: response.data!)
                    completion(false, true, sizes)
                }
            }catch{
                completion(true, false, nil)
            }
        }
    }
    
    class func productExtrasApi(id: Int, completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ extra: productsModel?)-> Void){
        let parametars = [
            "lang": "en",
            "product_id": id
            ] as [String : Any]
        Alamofire.request(URLs.products_additions, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
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
