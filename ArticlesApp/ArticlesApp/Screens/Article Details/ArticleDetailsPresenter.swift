//
//  ArticleDetailsPresenter.swift
//  Teste
//
//  Created by Diego Ribeiro on 12/05/24.
//

import Foundation

protocol ArticleDetailsPresenterCoordinatorDelegate: AnyObject {
    func goBack()
}

protocol ArticleDetailsPresenterViewDelegate: AnyObject {
    func reloadTableView()
    func loadingView(isLoading: Bool)
}

class ArticleDetailsPresenter {
    
    // MARK: Properties
    
    weak var coordinatorDelegate: ArticleDetailsPresenterCoordinatorDelegate?
    weak var viewDelegate: ArticleDetailsPresenterViewDelegate?
    
    var article: Article
    var poster: Data?
    
    var dateFormated: String {
        let dateString = article.publishedAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            let formattedDate = dateFormatter.string(from: date)
            return "Publication date: \(formattedDate)"
        } else {
            return "Publication date: \(article.publishedAt)"
        }
    }
    
    // MARK: Initialization
    
    init(article: Article, data: Data?) {
        self.article = article
        self.poster = data
    }

    // MARK: Methods
    
    func goBack() {
        coordinatorDelegate?.goBack()
    }
}
