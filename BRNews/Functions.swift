//
//  Functions.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 18/07/23.
//

import UIKit
import FirebaseAuth

struct Functions {
    
    //MARK: - Functions || UITextField
    static func TextFieldBottomLine(myTextField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 1, width: myTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: K.BrandColors.greyToWhite)?.cgColor
        myTextField.borderStyle = UITextField.BorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    }
    
    //MARK: - Functions || UIView
    static func addBorderTop(to view: UIView, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: thickness)
        view.layer.addSublayer(border)
    }
    
    //MARK: - Functions || Image from URL
    static func urlToImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let imageUrl = URL(string: urlString) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let e = error {
                    print("Error in retrieving image from URL: \(e)")
                    completion(UIImage(named: "Default-Image"))
                }
                
                if let safeImageData = data, let safeImage = UIImage(data: safeImageData) {
                    completion(safeImage)
                } else {
                    completion(nil)
                }
            }.resume()
        } else {
            completion(nil)
        }
    }
    
    //MARK: - Functions || Corner Radius
    static func putCornerRadius(uiElement: Any) {
        
    }
    
    //MARK: - Functions || UITextField
    static func hasTextFieldData(email: UITextField, password: UITextField) -> Bool {
        if email.text == "" {
            email.placeholder = "Enter your email!"
            return false
        } else if password.text == "" {
            password.placeholder = "Enter your password!"
            return false
        } else {
            return true
        }
    }
    
    static func textFieldShouldReturn(_ emailTextField: UITextField, _ passwordTextField: UITextField) {
        emailTextField.placeholder = "yourname@example.com"
        passwordTextField.placeholder = "yourpassword"
        
        emailTextField.endEditing(true) //to hide keyboard
        passwordTextField.endEditing(true)
    }
    
}
