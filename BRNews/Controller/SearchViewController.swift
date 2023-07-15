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
    var newsCell = NewsCell()
    var newsModelArray: [NewsModel] = []
    
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
        print("Success in getting newsModelArray Object")
        newsModelArray = news
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: News UITableView
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of cells: \(newsModelArray.count)")
        return newsModelArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        newsCell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! NewsCell
        let newsModel = newsModelArray[indexPath.row]
        newsCell.title.text = newsModel.title
        
        if let imageUrl = URL(string: newsModel.image) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let e = error {
                    // Handle error
                    DispatchQueue.main.async {
                        self.newsCell.newsImageView.image = UIImage(named: "Default-Image")
                    }
                    print("Failed to download image: \(String(describing: error))")
                    return
                }
                
                if let safeImageData = data, let image = UIImage(data: safeImageData) {
                    // Use the downloaded image
                    DispatchQueue.main.async {
                        self.newsCell.newsImageView.image = image
                    }
                }
            }.resume()
        }
        
        print("Cells poplated successfully!")
        return newsCell
    }
}
