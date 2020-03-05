//
//  sizesCell.swift
//  Chic Chicken
//
//  Created by Tariq on 3/3/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class sizesCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeNameLb: UILabel!
    @IBOutlet weak var salePriceLb: UILabel!
    @IBOutlet weak var generalPriceLb: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var viewRound: viewRound!
    
    func configureCell(sizes: productsData){
        if sizes.sale_price == ""{
            salePriceLb.text = sizes.price
            priceView.isHidden = true
            generalPriceLb.isHidden = true
        }else{
            salePriceLb.text = sizes.sale_price
            generalPriceLb.text = sizes.price
        }
        sizeNameLb.text = sizes.size
    }
    
    override var isSelected: Bool {
        didSet{
            viewRound.borderWidth = isSelected ? 1.0 : 0.5
            viewRound.borderColor = isSelected ? #colorLiteral(red: 0.6431372549, green: 0.1137254902, blue: 0.1294117647, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
