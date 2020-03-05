//
//  ContactUs.swift
//  Chic Chicken
//
//  Created by Tariq on 3/2/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ContactUs: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var message: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        nameTf.delegate = self
        phoneTf.delegate = self
        message.placeholder = "Message"
        // Do any additional setup after loading the view.
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
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard let name = nameTf.text, !name.isEmpty else {
            let messages = "Please enter your name"
            self.showAlert(title: "Contact Us", message: messages)
            return
        }
        guard let email = emailTf.text, !email.isEmpty else {
            let messages = "Please enter your email"
            self.showAlert(title: "Contact Us", message: messages)
            return
        }
        guard isValidEmail(testStr: emailTf.text ?? "") == true else {
            let messages = "Email is invalid"
            self.showAlert(title: "Contact Us", message: messages)
            return
        }
        guard let phone = phoneTf.text, !phone.isEmpty else {
            let messages = "Please enter your Phone Number"
            self.showAlert(title: "Contact Us", message: messages)
            return
        }
        guard let message = message.text, !message.isEmpty else {
            let messages = "Please enter your message"
            self.showAlert(title: "Contact Us", message: messages)
            return
        }
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        MoreApis.contactUsApi(email: email, name: name, phone: phone, message: message) { (dataError, isSuccess, contactMessage) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let contactMessage = contactMessage{
                        self.showAlert(title: "Contact Us", message: contactMessage.data ?? "")
                    }
                    self.view.endEditing(true)
                    self.stopAnimating()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
}
