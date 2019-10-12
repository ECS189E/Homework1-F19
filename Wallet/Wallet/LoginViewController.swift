//
//  ViewController.swift
//  Wallet
//
//  Created by Weisu Yin on 9/29/19.
//  Copyright © 2019 UCDavis. All rights reserved.
//

import UIKit
import PhoneNumberKit

class LoginViewController: UIViewController {

    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var numberTextField: PhoneNumberTextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var tapGesture = UITapGestureRecognizer()
    let phoneNumberKit = PhoneNumberKit()
    
    var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func initUI() {
        countryTextField.isUserInteractionEnabled = false
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        let phoneNumber = numberTextField.text?.filter { $0 >= "0" && $0 <= "9" } ?? ""
        if phoneNumber.count == 0 {
            errorLabel.text = "Please enter your phone number."
            errorLabel.textColor = .red
        } else if phoneNumber.count != 10 {
            errorLabel.text = "The phone number should be 10 digits."
            errorLabel.textColor = .red
        } else {
            do {
                let parsedPhoneNumber = try phoneNumberKit.parse(numberTextField.text ?? "")
                self.phoneNumber = phoneNumberKit.format(parsedPhoneNumber, toType: .e164)
                self.errorLabel.text = "Verification code has been sent to \(self.phoneNumber))"
                self.errorLabel.textColor = .green
                dismissKeyboard()
            }
            catch {
                errorLabel.text = "Please enter a valid phone number"
                errorLabel.textColor = .red
            }
        }
        errorLabel.isHidden = false
    }
    
    @objc func dismissKeyboard() {
        numberTextField.resignFirstResponder()
    }
    
}

