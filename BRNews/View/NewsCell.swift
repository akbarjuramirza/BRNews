//
//  NewsCell.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 12/07/23.
//

import UIKit

class NewsCell: UITableViewCell {
    
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsBubble: UIView!
    @IBOutlet weak var title: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsBubble.layer.cornerRadius = newsBubble.frame.size.height / 5
        newsImageView.layer.cornerRadius = newsImageView.frame.size.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
