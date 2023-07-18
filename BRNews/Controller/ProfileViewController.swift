//
//  ProfileViewController.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 18/07/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bottomBarView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Adding border to top bar view
        Functions.addBorderTop(to: bottomBarView, color: UIColor(named: K.BrandColors.redToWhite)!, thickness: 1.5)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        
    }
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func savedNewsButtonPressed(_ sender: UIButton) {
    }
    
    

}
