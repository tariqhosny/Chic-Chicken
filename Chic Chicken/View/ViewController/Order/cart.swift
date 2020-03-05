//
//  cart.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class cart: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var productsCountLb: UILabel!
    @IBOutlet weak var productsPriceLb: UILabel!
    @IBOutlet weak var taxesLb: UILabel!
    @IBOutlet weak var shopingLb: UILabel!
    @IBOutlet weak var TotalPriceLb: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    var cart = [CartList]()
    var cartID = Int()
    var currency = String()
    var totalPrice = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        priceView.isHidden = true
        cartTableView.delegate = self
        cartTableView.dataSource = self
        laodCart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        laodCart()
    }
    
    func laodCart(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        OrderApis.listCartApi { (dataError, isSuccess, cart) in
            if dataError!{
                print("data error")
                if self.cart.count == 0 {
                    self.priceView.isHidden = true
                }
                self.stopAnimating()
            }else{
                if isSuccess!{
                    self.priceView.isHidden = false
                    if let cart = cart?.data?.list{
                        self.cart = cart
                        self.currency = self.cart[0].currency ?? ""
                        self.cartTableView.reloadData()
                        if self.cart.count == 0 {
                            self.priceView.isHidden = true
                        }
                    }
                    if let prices = cart?.data{
                        var productPrice = 0
                        for item in 0...self.cart.count - 1{
                            productPrice += Int(self.cart[item].total_price_with_addtions ?? "0") ?? 0
                        }
                        self.totalPrice = "\(prices.price ?? 0)"
                        self.productsCountLb.text = "\(self.cart.count) Meals"
                        self.productsPriceLb.text = "\(productPrice)" + self.currency
                        self.taxesLb.text = "\(prices.total_tax ?? 0)" + self.currency
                        self.shopingLb.text = (prices.total_delevery_fees ?? "") + self.currency
                        self.TotalPriceLb.text = "\(prices.price ?? 0)" + self.currency
                    }
                    self.stopAnimating()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func checkOutPressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Order", bundle: Bundle.main).instantiateViewController(withIdentifier: "createOrder") as? CreateOrder
        vc?.price = totalPrice
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
extension cart: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartCell
        cell.plus = {
            self.startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
            self.cartID = self.cart[indexPath.row].cart_id ?? 0
            OrderApis.cartApi(url: URLs.plusCart, id: self.cartID, completion: { (dataError, isSuccess, message) in
                if dataError!{
                    print("data error")
                    self.stopAnimating()
                }else{
                    if isSuccess!{
                        print("increased")
                        self.laodCart()
                    }else{
                        print("failed")
                    }
                    self.stopAnimating()
                }
            })
        }
        
        cell.min = {
            if self.cart[indexPath.row].quantity != "1"{
                self.startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
                self.cartID = self.cart[indexPath.row].cart_id ?? 0
                OrderApis.cartApi(url: URLs.minCart, id: self.cartID, completion: { (dataError, isSuccess, message) in
                    if dataError!{
                        print("data error")
                        self.stopAnimating()
                    }else{
                        if isSuccess!{
                            print("decreased")
                            self.laodCart()
                        }else{
                            print("failed")
                        }
                        self.stopAnimating()
                    }
                })
            }
        }

        cell.delete = {
            self.startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
            self.cartID = self.cart[indexPath.row].cart_id ?? 0
            OrderApis.cartApi(url: URLs.deleteCart, id: self.cartID, completion: { (dataError, isSuccess, message) in
                if dataError!{
                    print("data error")
                    self.stopAnimating()
                }else{
                    if isSuccess!{
                        print("increased")
                        self.laodCart()
                    }else{
                        print("failed")
                    }
                    self.stopAnimating()
                }
            })
            if self.cart.count == 1 {
                self.cart.removeAll()
                self.cartTableView.reloadData()
                self.priceView.isHidden = true
            }
        }
        
        cell.extra = {
            let vc = UIStoryboard.init(name: "Order", bundle: Bundle.main).instantiateViewController(withIdentifier: "extrasCart") as? extrasCart
            vc?.cartID = self.cart[indexPath.item].cart_id ?? 0
            vc?.quantity = Int(self.cart[indexPath.item].quantity ?? "") ?? 0
            self.present(vc!, animated: false)
        }
        
        cell.selectionStyle = .none
        cell.configureCell(product: cart[indexPath.row])
        return cell
    }
}
