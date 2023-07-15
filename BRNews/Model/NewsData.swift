//
//  NewsData.swift
//  BRNews
//
//  Created by Akbarjon Juramirzaev on 12/07/23.
//

import Foundation

struct NewsData: Codable {
    let results: [Results]
}

//results[6].title
//results[6].description
//results[6].image_url

struct Results: Codable {
    let title: String?
    let description: String?
    let content: String?
    let image_url: String?
}
