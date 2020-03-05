//
//  cart.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class cart: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
//        navigationController?.navigationBar.backItem?.title = " "
        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backItem?.title = ""
    }
    
}
extension cart: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartCell
        return cell
    }
    
    
}
