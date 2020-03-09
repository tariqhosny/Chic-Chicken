//
//  includesCell.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class includesCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    func configure(extra: productsData){
        titleLb.text = extra.title
        priceLb.text = "Price: \(extra.price_general ?? "")\(helper.getCurrency() ?? "")"
        let urlWithOutEncoding = ("\(URLs.imageUrl)\(extra.image!)")
        let encodedLink = urlWithOutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)"){
            productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkImage.image = selected ? #imageLiteral(resourceName: "check") : #imageLiteral(resourceName: "uncheck")
    }

}
