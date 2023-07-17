//
//  NewsViewController.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 17/07/23.
//

import UIKit

class NewsViewController: UIViewController {
    
    
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var titleText = String()
    var image = UIImage()
    var descriptionText = String()
    var contentText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText
        newsImage.image = image
        descriptionLabel.text = descriptionText
        contentLabel.text = contentText

        // Ading top border to bottom bar
        bottomBarView.addBorderTop(color: UIColor(named: "RedToWhite")!, thickness: 1.5)
    }

}

