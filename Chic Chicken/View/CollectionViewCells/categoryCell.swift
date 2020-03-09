//
//  categoryCell.swift
//  Chic Chicken
//
//  Created by Tariq on 11/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class categoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLb: UILabel!
    
    func configureCell(category: productsData){
        categoryNameLb.text = category.title
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(category.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        categoryImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            categoryImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
}
