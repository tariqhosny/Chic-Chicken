//
//  more.swift
//  Chic Chicken
//
//  Created by Tariq on 11/20/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class more: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func recentOrders(_ sender: Any) {
        let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "orderList")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
