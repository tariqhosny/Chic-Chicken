//
//  orderList.swift
//  Chic Chicken
//
//  Created by Tariq on 11/24/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class orderList: UIViewController {
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        
//        navigationController?.navigationBar.backItem?.title = " "
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backItem?.title = ""
    }

}
extension orderList: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderListCell", for: indexPath) as! orderListCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "orderDetails", sender: nil)
    }
    
}
