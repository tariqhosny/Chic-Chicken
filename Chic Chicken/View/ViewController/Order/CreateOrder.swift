//
//  CreateOrder.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class CreateOrder: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
//        navigationController?.navigationBar.backItem?.title = " "
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backItem?.title = ""
    }
    
}
