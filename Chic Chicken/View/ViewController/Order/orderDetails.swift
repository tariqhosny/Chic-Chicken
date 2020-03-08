//
//  orderDetails.swift
//  Chic Chicken
//
//  Created by Tariq on 11/24/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class orderDetails: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var mealsTableView: UITableView!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var paymentMethodLb: UILabel!
    @IBOutlet weak var taxesLb: UILabel!
    @IBOutlet weak var deleveryFeesLb: UILabel!
    @IBOutlet weak var totalPriceLb: UILabel!
    
    var details = OrderData()
    var products = [OrderDetailsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        fillData()
        loadOrders()
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func fillData(){
        taxesLb.text = "\(details.tax ?? 0)\(helper.getCurrency() ?? "")"
        deleveryFeesLb.text = "\(details.delevery_fees ?? "")\(helper.getCurrency() ?? "")"
        totalPriceLb.text = "\(details.order_total_price ?? "")\(helper.getCurrency() ?? "")"
        addressLb.text = "\(details.customer_country ?? ""), \(details.customer_city ?? ""), \(details.customer_street ?? "")"
        paymentMethodLb.text = "Cash on Deliverd"
    }
    
    func loadOrders(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        OrderApis.listOrderDetailsApi(id: details.order_id ?? 0) { (dataError, isSuccess, orders) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let orders = orders?.data{
                        self.products = orders
                        self.mealsTableView.reloadData()
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
extension orderDetails: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailsCell", for: indexPath) as! orderDetailsCell
        cell.configureCell(order: products[indexPath.row])
        cell.extra = {
            let vc = UIStoryboard.init(name: "Order", bundle: Bundle.main).instantiateViewController(withIdentifier: "extrasCart") as? extrasCart
            vc?.cartID = self.details.order_id ?? 0
            vc?.productId = Int(self.products[indexPath.item].product_id ?? "") ?? 0
            vc?.quantity = Int(self.products[indexPath.item].product_quantity ?? "") ?? 0
            self.present(vc!, animated: false)
        }
        return cell
    }
    
    
}
