//
//  LoginViewController.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 11/07/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TextFieldBottomLine(myTextField: emailTextField)
        TextFieldBottomLine(myTextField: passwordTextField)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //heads-up to display error
                    print("Error in login \(e)")
                } else {
                    print("Success!")
                    //Navigate to News Search Screen
                }
            }
        }
    }
    
    
    
    //MARK: TextField Bottom line
    func TextFieldBottomLine(myTextField: UITextField) {
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 1, width: myTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "GreyToWhite")?.cgColor
        myTextField.borderStyle = UITextField.BorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    }

}
