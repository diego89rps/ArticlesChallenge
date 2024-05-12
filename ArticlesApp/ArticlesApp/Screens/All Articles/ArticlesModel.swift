//
//  MainModel.swift
//  Teste
//
//  Created by Diego Ribeiro on 01/04/24.
//

import Foundation

struct ArticlesModel: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    // second view
    let publishedAt: String
    let content: String
}
