//
//  SliderApi.swift
//  Chic Chicken
//
//  Created by Tariq on 3/1/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class SliderApi: NSObject {

    class func sliderApi(completion: @escaping(_ dataError: Bool?, _ success: Bool?, _ photos: productsModel?)-> Void){
        let parametars = [
            "lang": "en"
        ]
        Alamofire.request(URLs.slider, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
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
    
}
