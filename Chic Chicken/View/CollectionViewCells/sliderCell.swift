//
//  sliderCell.swift
//  Chic Chicken
//
//  Created by Tariq on 11/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class sliderCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderImage: UIImageView!
    
    func configureCell(images: productsData){
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(images.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        sliderImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            sliderImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
}
