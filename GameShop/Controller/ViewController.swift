//
//  ViewController.swift
//  GameShop
//
//  Created by Ahmet Mücahid BOZKURT on 24.02.2020.
//  Copyright © 2020 Ahmet Mucahid BOZKURT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        validationLabel.text = ""
        
        mailAdressTextField.layer.cornerRadius = 5.0
        mailAdressTextField.layer.borderWidth = 1.0
        mailAdressTextField.layer.borderColor = UIColor.orange.cgColor
        
        passwordTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.orange.cgColor
        
        self.mailAdressTextField.tag = 0
        self.passwordTextField.tag = 1
        self.mailAdressTextField.delegate = self
        self.passwordTextField.delegate = self
       
    }
    
    @IBAction func signInButton(_ sender: Any) {
        if mailAdressTextField.text == "appcent" && passwordTextField.text == "2013" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
            self.navigationController?.setViewControllers([mainVC], animated: true)
        } else {
            validationLabel.text = "Username or Password is incorrect."
        }
        
    }
    
    
    // Move to next text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tagBasedTextField(textField)
        return true
    }

    private func tagBasedTextField(_ textField: UITextField) {
        let nextTextFieldTag = textField.tag + 1

        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }

    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.mailAdressTextField:
            self.passwordTextField.becomeFirstResponder()
        default:
            self.passwordTextField.resignFirstResponder()
        }
    }

}

// Keyboard Hide
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
}

