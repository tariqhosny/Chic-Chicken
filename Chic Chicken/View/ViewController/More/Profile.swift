//
//  Profile.swift
//  FruitInn
//
//  Created by Tariq on 1/8/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Profile: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var oldPasswordTf: UITextField!
    @IBOutlet weak var newPasswordTf: UITextField!
    @IBOutlet weak var confirmPasswordTf: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var dataOrPassword = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleImage()
        userDataAppearance(status: true)
        userDataHandelRefresh()
        phoneTf.delegate = self
        nameTF.delegate = self
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTF{
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
    
    func userDataAppearance(status: Bool){
        nameTF.isHidden = !status
        emailTf.isHidden = !status
        phoneTf.isHidden = !status
        oldPasswordTf.isHidden = status
        newPasswordTf.isHidden = status
        confirmPasswordTf.isHidden = status
    }
    
    func userDataHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        AuthApi.userDataApi { (isSuccess, userData) in
            if isSuccess!{
                if let userData = userData?.data{
                    self.nameTF.text = userData[0].name
                    self.emailTf.text = userData[0].email
                    self.phoneTf.text = userData[0].phone
                }
                self.stopAnimating()
            }else{
                self.showAlert(title: "Connection", message: "Please check your internet connection")
                self.stopAnimating()
            }
        }
    }
    
    @IBAction func segmentedBtn(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            dataOrPassword = 0
            userDataAppearance(status: true)
            self.view.endEditing(true)
        case 1:
            dataOrPassword = 1
            self.oldPasswordTf.text = ""
            self.newPasswordTf.text = ""
            self.confirmPasswordTf.text = ""
            userDataAppearance(status: false)
            self.view.endEditing(true)
        default:
            print("AnyThing")
        }
    }
    
    @IBAction func editBtn(_ sender: Any) {
        self.view.endEditing(true)
        if dataOrPassword == 0 {
            guard let name = nameTF.text, !name.isEmpty else {
                let messages = "Please enter your name"
                self.showAlert(title: "Profile", message: messages)
                return
            }
            
            guard let email = emailTf.text, !email.isEmpty else {
                let messages = "Please enter your email"
                self.showAlert(title: "Profile", message: messages)
                return
            }
            
            guard isValidEmail(testStr: emailTf.text ?? "") == true else {
                let messages = "Email not correct"
                self.showAlert(title: "Profile", message: messages)
                return
            }
            
            guard let phone = phoneTf.text, !phone.isEmpty else {
                let messages = "Please enter your phone"
                self.showAlert(title: "Profile", message: messages)
                return
            }
            startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
            AuthApi.updateProfileApi(email: email, name: name, phone: phone) { (isSuccess, messages) in
                if isSuccess!{
                    if messages?.status ?? false{
                        self.showAlert(title: "Profile", message: (messages?.data)!)
                        self.userDataHandelRefresh()
                    }else{
                        if let message = messages?.errors{
                            self.showAlert(title: "Profile", message: message.email?[0] ?? "")
                            self.userDataHandelRefresh()
                        }
                    }
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }else{
            guard let oldPassword = oldPasswordTf.text, !oldPassword.isEmpty else {
                let messages = "Please enter your old password"
                self.showAlert(title: "Password", message: messages)
                return
            }
            
            guard let newPassword = newPasswordTf.text, !newPassword.isEmpty else {
                let messages = "Please enter your new password"
                self.showAlert(title: "Password", message: messages)
                return
            }
            
            guard oldPasswordTf.text?.count ?? 0 >= 6, newPasswordTf.text?.count ?? 0 >= 6 else {
                let messages = "The password must be at least 6 characters"
                self.showAlert(title: "Password", message: messages)
                return
            }
            
            guard let confirmPassword = confirmPasswordTf.text, !confirmPassword.isEmpty else {
                let messages = "Please confirm password"
                self.showAlert(title: "Password", message: messages)
                return
            }
            startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
            AuthApi.updatePasswordApi(password: oldPassword, newPassword: confirmPassword) { (isSuccess, message) in
                if isSuccess! {
                    if message?.status ?? false{
                        self.showAlert(title: "Password", message: (message?.data)!)
                        self.oldPasswordTf.text = ""
                        self.newPasswordTf.text = ""
                        self.confirmPasswordTf.text = ""
                    }else{
                        if let message = message?.errors{
                            self.showAlert(title: "Password", message: message.email?[0] ?? "")
                            self.oldPasswordTf.text = ""
                            self.newPasswordTf.text = ""
                            self.confirmPasswordTf.text = ""
                        }
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
