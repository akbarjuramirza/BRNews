//
//  SearchViewController.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 12/07/23.
//

import UIKit
import FirebaseAuth

class SearchViewController: UIViewController {
    
    //MARK: Auto Rotation Cancel
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var newsManager = NewsManager()
    var cell = NewsCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        newsManager.delegate = self
        
        //Put Top Border For Bottom Bar
        let bottomView = bottomBarView
        bottomView?.addBorderTop(color: UIColor(named: "RedToBlue")!, thickness: 1.5)
        
        //Hiding Navigation Back Button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //CornerRadius Search TextField
        searchTextField.layer.cornerRadius = searchTextField.frame.size.height / 4
        
        //Register XIB Newbubble
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let safeKey = searchTextField.text {
            newsManager.getKeyWord(key: safeKey)
        }
    }
    
    
    
    //Log Out
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }

}

//MARK: Adding Border
extension UIView {
    func addBorderTop(color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
        layer.addSublayer(border)
    }

}

//MARK: NewsManagerDelegate
extension SearchViewController: NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager, news: [NewsModel]) {
    
        DispatchQueue.main.async {
            
            for index in news {
                //start of for loop
                self.cell.title.text = index.title
                //1. Convert Image Url String to URL object
                if let imageUrl = URL(string: index.image) {
                    //2. Download the image from the URL
                    if let data = try? Data(contentsOf: imageUrl) {
                        //3. Convert the image data into a UIImage
                        if let image = UIImage(data: data) {
                            //4. Set the image to your UIImageView
                            self.cell.newsImageView.image = image
                        } else {
                            self.cell.newsImageView.image = UIImage(named: "Profile-Image")
                        }
                    }
                }
                //end of for loop
            }
           //end of DispatchQueue
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

//MARK: News UITableView
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! NewsCell
        
        return cell
    }
}
