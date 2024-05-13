//
//  MainPresenter.swift
//  Teste
//
//  Created by Diego Ribeiro on 01/04/24.
//

import Foundation

protocol ArticlesPresenterCoordinatorDelegate: AnyObject {
    func goToDetailView(article: Article, poster: Data?)
}

protocol ArticlesPresenterViewDelegate: AnyObject {
    func reloadTableView()
    func loadingView(isLoading: Bool)
}

class ArticlesPresenter {
    
    // MARK: Properties
    
    weak var coordinatorDelegate: ArticlesPresenterCoordinatorDelegate?
    weak var viewDelegate: ArticlesPresenterViewDelegate?
    
    var articlesList: ArticlesModel?
    var service: DataProviderProtocol
    
    var allPosters: [(data: Data, index: Int)] = []
    
    var numberOfArticles: Int {
        return articlesList?.articles.count ?? 0
    }
    
    // MARK: Initialization
    
    init(service: DataProviderProtocol = DataProvider()) {
        self.service = service
    }
    
    // MARK: Methods
    
    @MainActor
    func fetchArticles() {
        viewDelegate?.loadingView(isLoading: true)
        Task {
            do {
                let result: ArticlesModel = try await service.fetchAllArticles()
                self.articlesList = result
                self.viewDelegate?.reloadTableView()
                self.viewDelegate?.loadingView(isLoading: false)
            } catch {
                print(error)
            }
        }
    }
    
    func downloadImage(posterURL: String, index: Int) async -> Data?  {
        do {
            let imageData = try await service.fetchImageData(imageURLString: posterURL)
            self.allPosters.append((imageData, index))
            return imageData
        } catch {
            return nil
        }
    }
    
    func articlePosterPath(at index: Int) -> String? {
        guard let articles = articlesList?.articles, index >= 0 && index < numberOfArticles,
              let path = articles[index].urlToImage else {
            return nil
        }
        
       return path
    }
    
    func articleAuthor(at index: Int) -> String {
        guard let articles = articlesList?.articles, index >= 0 && index < numberOfArticles,
                let author = articles[index].author else {
            return "Author not found"
        }
        return "Author: \(author)"
    }
    
    func articleTitle(at index: Int) -> String {
        guard let articles = articlesList?.articles, index >= 0 && index < numberOfArticles else {
            return "Title not found"
        }
        return articles[index].title
    }
    
    func articleDescription(at index: Int) -> String {
        guard let articles = articlesList?.articles, index >= 0 && index < numberOfArticles else {
            return "Description not found"
        }
        let stringWithoutNewlines = articles[index].description.replacingOccurrences(of: "\n", with: "")

        return stringWithoutNewlines
    }
    
    func goToDetails(index: Int) {
        guard let articles = articlesList?.articles, index >= 0 && index < numberOfArticles else { return }
        let data = allPosters.first { $0.index == index }
        
        coordinatorDelegate?.goToDetailView(article: articles[index], poster: data?.data)
    }
}
