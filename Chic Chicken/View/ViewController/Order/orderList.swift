//
//  orderList.swift
//  Chic Chicken
//
//  Created by Tariq on 11/24/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class orderList: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var ordersCountLb: UILabel!
    @IBOutlet weak var ordersTableView: UITableView!
    
    var orders = [OrderData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        loadOrders()
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
    }
    
    func loadOrders(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        OrderApis.listOrderApi { (dataError, isSuccess, orders) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let orders = orders?.data{
                        self.orders = orders
                        self.ordersCountLb.text = "\(self.orders.count)"
                        self.ordersTableView.reloadData()
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
extension orderList: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderListCell", for: indexPath) as! orderListCell
        cell.selectionStyle = .none
        cell.configure(order: orders[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Order", bundle: Bundle.main).instantiateViewController(withIdentifier: "orderDetails") as? orderDetails
        vc?.details = orders[indexPath.item]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
