//
//  register.swift
//  Chic Chicken
//
//  Created by Tariq on 11/17/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class register: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable  {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var cityTf: UITextField!
    @IBOutlet weak var branchesTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTf.delegate = self
        phoneTf.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTf{
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z أ إ  ض ص ث ق ف غ ع ه خ ح  ج د ش ي ب ل ا ت ن م ك  ط ئ ء ؤ ر س ذ لا ى ة و ز ظ].*", options: [])
                if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                    return false
                }
            }
            catch {
                print("ERROR")
            }
            return true
        }else{
            do {
                let regex = try NSRegularExpression(pattern: ".*[^0-9٠-٩+#*].*", options: [])
                if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                    return false
                }
            }
            catch {
                print("ERROR")
            }
            return true
        }
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let name = nameTf.text, !name.isEmpty else {
            let messages = "Please enter your name"
            self.showAlert(title: "Register", message: messages)
            return
        }
        guard let phone = phoneTf.text, !phone.isEmpty else {
            let messages = "Please enter your Phone Number"
            self.showAlert(title: "Register", message: messages)
            return
        }
        guard let email = emailTf.text, !email.isEmpty else {
            let messages = "Please enter your email"
            self.showAlert(title: "Register", message: messages)
            return
        }
        guard isValidEmail(testStr: emailTf.text ?? "") == true else {
            let messages = "Email is invalid"
            self.showAlert(title: "Register", message: messages)
            return
        }
        guard let password = passwordTf.text, !password.isEmpty else {
            let messages = "Please enter your password"
            self.showAlert(title: "Register", message: messages)
            return
        }
        guard passwordTf.text?.count ?? 0 >= 6 else {
            let messages = "The password must be at least 6 characters"
            self.showAlert(title: "Register", message: messages)
            return
        }
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        AuthApi.registerApi(name: name, email: email, phone: phone, password: password) { (isSuccess, register) in
            if isSuccess!{
                if register?.status ?? false{
                    if let registerData = register?.data{
                        helper.saveUserToken(token: registerData.user_token ?? "")
                        print(helper.getUserToken() ?? "")
                        helper.restartApp()
                    }
                }else{
                    self.stopAnimating()
                    self.showAlert(title: "Register", message: "The email has already been taken")
                }
            }else{
                self.showAlert(title: "Connection", message: "Please check your internet connection")
                self.stopAnimating()
            }
            
        }
    }
    
}
