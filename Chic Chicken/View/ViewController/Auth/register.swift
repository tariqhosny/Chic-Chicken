//
//  register.swift
//  Chic Chicken
//
//  Created by Tariq on 11/17/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class register: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var cityTf: UITextField!
    @IBOutlet weak var branchesTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    let branches = ["Alex", "Cairo", "Giza", "Mansoura", "Bani-Suif", "Minia", "Assut"]
    let branchesPicker = UIPickerView()
    let cityPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTf.inputView = cityPicker
        branchesTf.inputView = branchesPicker
        nameTf.delegate = self
        phoneTf.delegate = self
        cityPicker.delegate = self
        cityPicker.dataSource = self
        branchesPicker.delegate = self
        branchesPicker.dataSource = self
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
        guard let city = cityTf.text, !city.isEmpty else {
            let messages = "Please select your nearest city"
            self.showAlert(title: "Register", message: messages)
            return
        }
        guard let branch = branchesTf.text, !branch.isEmpty else {
            let messages = "Please select your nearest branch"
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
    }
    
}
extension register: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return branches.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return branches[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPicker{
            cityTf.text = branches[row]
        }else{
            branchesTf.text = branches[row]
        }
    }
    
}
