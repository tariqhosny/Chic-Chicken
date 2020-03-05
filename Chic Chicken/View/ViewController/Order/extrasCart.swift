//
//  checkOut.swift
//  FruitInn
//
//  Created by Tariq on 12/25/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class extrasCart: UIViewController, NVActivityIndicatorViewable  {
    
    @IBOutlet weak var extraTableView: UITableView!
    @IBOutlet weak var popView: UIView!
    
    var extras = [productsData]()
    var cartID = Int()
    var quantity = Int()
    var productId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPop(_:))))
        
        extraTableView.delegate = self
        extraTableView.dataSource = self
        
        loadExtra()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func onTap(_ sender:UIPanGestureRecognizer) {
       dismiss(animated: false, completion: nil)
    }
    
    @objc func onTapPop(_ sender:UIPanGestureRecognizer) {
        print("متدوسش هنا تانى .... يلا يا كوكو متنحش")
    }
    
    func loadExtra(){
        self.startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        if productId == 0{
            OrderApis.extraCartApi(id: self.cartID, completion: { (dataError, isSuccess, extra) in
                if dataError!{
                    print("data error")
                    self.stopAnimating()
                }else{
                    if isSuccess!{
                        if let extra = extra?.data{
                            self.extras = extra
                            self.extraTableView.reloadData()
                        }
                        self.stopAnimating()
                    }else{
                        self.stopAnimating()
                    }
                }
            })
        }else{
            OrderApis.listOrderExtraApi(orderId: cartID, productId: productId){ (dataError, isSuccess, orders) in
                if dataError!{
                    print("data error")
                    self.stopAnimating()
                }else{
                    if isSuccess!{
                        if let orders = orders?.data{
                            self.extras = orders
                            self.extraTableView.reloadData()
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
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
extension extrasCart: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "extraCartCell", for: indexPath) as! extraCartCell
        cell.configure(extra: extras[indexPath.row], quantity: quantity)
        return cell
    }
    
    
}
