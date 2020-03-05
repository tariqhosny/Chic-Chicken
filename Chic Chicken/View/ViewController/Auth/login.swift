//
//  ViewController.swift
//  Chic Chicken
//
//  Created by Tariq on 11/17/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class login: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTf.text, !email.isEmpty else {
            let messages = "Please enter your email"
            self.showAlert(title: "Login", message: messages)
            return
        }
        guard isValidEmail(testStr: emailTf.text ?? "") == true else {
            let messages = "Email is invalid"
            self.showAlert(title: "Login", message: messages)
            return
        }
        guard let password = passwordTf.text, !password.isEmpty else {
            let messages = "Please enter your password"
            self.showAlert(title: "Login", message: messages)
            return
        }
        guard passwordTf.text?.count ?? 0 >= 6 else {
            let messages = "The password must be at least 6 characters"
            self.showAlert(title: "Login", message: messages)
            return
        }
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        AuthApi.loginApi(email: email, password: password) { (success, loginData)  in
            if success! {
                if let login = loginData?.data{
                    helper.saveUserToken(token: login.user_token ?? "")
                    print(helper.getUserToken() ?? "")
                    helper.restartApp()
                }
                if loginData?.status == false{
                    self.showAlert(title: "Login", message: "Unauthorised")
                    self.passwordTf.text = ""
                    self.stopAnimating()
                }
            }else{
                self.showAlert(title: "Connection", message: "Please check your internet connection")
            }
            
        }
    }
    
    

}

