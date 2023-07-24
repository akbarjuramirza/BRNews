//
//  SearchViewController.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 12/07/23.
//

import UIKit
import FirebaseAuth

class SearchViewController: UIViewController {
    
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
        tableView.delegate = self
        searchTextField.delegate = self
        
        //Put Top Border For Bottom Bar
        Functions.addBorderTop(to: bottomBarView, color: UIColor(named: K.BrandColors.redToBlue)!, thickness: 1.5)
         
        //Hiding Navigation Back Button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //CornerRadius Search TextField
        searchTextField.layer.cornerRadius = searchTextField.frame.size.height / 4
        
        //Register XIB Newbubble
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.bubbleCellIdentifier)
        
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
    
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func historyButtonPressed(_ sender: UIButton) {
    }
    
    
}

//MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
    //Send API request
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.placeholder = "Search"
        searchTextField.endEditing(true)
        
        if searchTextField.text == "" {
            searchTextField.placeholder = "Type something!"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.placeholder = "Search"
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            searchTextField.placeholder = "Type something!"
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let safeKey = searchTextField.text {
            newsManager.getKeyWord(key: safeKey)
        }
        
        searchTextField.text = ""
        searchTextField.endEditing(true)
    }
}

//MARK: - NewsManagerDelegate
extension SearchViewController: NewsManagerDelegate {
    
    func didUpdateNews(_ newsManager: NewsManager, news: [NewsModel]) {
        newsModelArray = news
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModelArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        newsCell = tableView.dequeueReusableCell(withIdentifier: K.bubbleCellIdentifier, for: indexPath) as! NewsCell
        let newsModel = newsModelArray[indexPath.row]
        self.newsCell.title.text = newsModel.title
        if let imageURL = URL(string: newsModel.image) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let e = error {
                    print("Error in retieving image from URL: \(e)")
                    self.newsCell.newsImageView.image = UIImage(named: "Default-Image")
                }
                
                if let safeImageData = data, let safeImage = UIImage(data: safeImageData) {
                    DispatchQueue.main.async {
                        self.newsCell.newsImageView.image = safeImage
                    }
                }
            } .resume()
        }
        return newsCell
    }
    
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = newsModelArray[indexPath.row]
        performSegue(withIdentifier: K.searchToNews, sender: selectedNews)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.searchToNews {
            let destinationVC = segue.destination as! NewsViewController
            if let selectedNews = sender as? NewsModel {
                destinationVC.titleText = selectedNews.title
                if let imageURL = URL(string: selectedNews.image) {
                    URLSession.shared.dataTask(with: imageURL) { data, response, error in
                        if let e = error {
                            print("Error in retireving image from URL: \(e)")
                            destinationVC.image = UIImage(named: "Default-Image")!
                        }
                        
                        if let safeImageData = data, let safeImage = UIImage(data: safeImageData) {
                            destinationVC.image = safeImage
                        }
                    } .resume()
                }
                destinationVC.descriptionText = selectedNews.description
                destinationVC.contentText = selectedNews.content
            }
        }
    }
    
    
}

