//
//  NewsManager.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 12/07/23.
//

import Foundation

protocol NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager, news: [NewsModel])
    func didFailWithError(error: Error)
}

struct NewsManager {
    
    let baseURL = "https://newsdata.io/api/1/news?apikey="
    let api_key = "pub_19872f2cba409ef8b8ef801d4a5399ee53d54"
    
    var delegate: NewsManagerDelegate?
    
    //Get URL
    func getKeyWord(key: String) {
        let urlString = "\(baseURL)\(api_key)&language=en&q=\(key)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    
    //Make request
    func performRequest(urlString: String) {
        //1. Create URl
        if let url = URL(string: urlString) {
            
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print("Error in getting RESPONSE: \(String(describing: error))")
                    return
                }
                if let safeData = data {
                    if let parsedData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateNews(self, news: parsedData)
                    }
                }
            }
            
            //4. Start task
            task.resume()
        }
    }
    
    
    //Parse JSON
    func parseJSON(_ data: Data) -> [NewsModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsData.self, from: data)
            
            var parsedData: [NewsModel] = []
            
            for news in decodedData.results {
                let title = news.title ?? "Default title"
                let description = news.description ?? "Default decription"
                let content = news.content ?? "Default content"
                let image_url = news.image_url ?? "https://i.pinimg.com/originals/83/bc/8b/83bc8b88cf6bc4b4e04d153a418cde62.jpg"
                
                let newsModel = NewsModel(title: title, description: description, content: content, image: image_url)
                parsedData.append(newsModel)
            }
            
            return parsedData
            
        } catch {
            delegate?.didFailWithError(error: error)
            
            // do research
            // fatalError("error parsing data \(error)")
            print("Error in parsing: \(error)")
            return nil
        }
    }
}
