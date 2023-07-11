//
//  SignUpViewController.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 11/07/23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    //MARK: Auto Rotation Cancel
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextFieldBottomLine(myTextField: emailTextField)
        TextFieldBottomLine(myTextField: passwordTextField)
        
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //heads-up to display error
                    print("Error in sign up: \(e)")
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
