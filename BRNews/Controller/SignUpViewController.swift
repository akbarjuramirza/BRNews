//
//  SignUpViewController.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 11/07/23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

        Functions.TextFieldBottomLine(myTextField: emailTextField)
        Functions.TextFieldBottomLine(myTextField: passwordTextField)
        
        //CornerRadius Sign up Button
        signUpButton.layer.cornerRadius = signUpButton.frame.size.height / 4
        
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        Functions.textFieldShouldReturn(emailTextField, passwordTextField)
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //heads-up to display error
                    print("Error in sign up!: \(e)")
                    _ = Functions.hasTextFieldData(email: self.emailTextField, password: self.passwordTextField)
                } else {
                    print("Success in sign up!")
                    //Navigate to News Search Screen
                    self.performSegue(withIdentifier: K.FStore.signUpToSearch, sender: self)
                }
            }
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Functions.textFieldShouldReturn(emailTextField, passwordTextField)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return Functions.hasTextFieldData(email: emailTextField, password: passwordTextField)
    }
}
