//
//  ViewController.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 11/07/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: Auto Rotation Cancel
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet weak var RegisterView: UIView!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var guideButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        RegisterView.layer.cornerRadius = RegisterView.frame.size.height / 12
        SignUpButton.layer.cornerRadius = SignUpButton.frame.size.height / 2
        LoginButton.layer.cornerRadius = LoginButton.frame.size.height / 2
        guideButton.layer.cornerRadius = guideButton.frame.size.height / 2
    }
    
    
    //MARK: Guide Book Pop-up
    @IBAction func guideButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Pop-up Title", message: "Here you are supposed to have a guide book, but don't worry it is coming soon!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    


}


