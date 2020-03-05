//
//  AboutUs.swift
//  Chic Chicken
//
//  Created by Tariq on 3/2/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AboutUs: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var aboutImage: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var detailsLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        loadAboutUs()
    }
    
    func loadAboutUs(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        MoreApis.aboutApi { (dataError, isSuccess, aboutUs) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let about = aboutUs?.data{
                        self.titleLb.text = about[0].title
                        self.detailsLb.text = about[0].description
                    }
                    self.stopAnimating()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }

}
