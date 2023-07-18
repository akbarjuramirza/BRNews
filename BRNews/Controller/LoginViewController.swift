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
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Functions.TextFieldBottomLine(myTextField: emailTextField)
        Functions.TextFieldBottomLine(myTextField: passwordTextField)
        
        
        //CornerRadius Login Button
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 4
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        Functions.textFieldShouldReturn(emailTextField, passwordTextField)
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //heads-up to display error
                    print("Error in login!: \(e)")
                    let result = Functions.hasTextFieldData(email: self.emailTextField, password: self.passwordTextField)
                } else {
                    print("Success in login!")
                    //Navigate to News Search Screen
                    self.performSegue(withIdentifier: K.FStore.loginToSearch, sender: self)
                }
            }
        }
    }

}

//MARK: - UITextField
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Functions.textFieldShouldReturn(emailTextField, passwordTextField)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return Functions.hasTextFieldData(email: emailTextField, password: passwordTextField)
    }
}
