//
//  MainPresenter.swift
//  Teste
//
//  Created by Diego Ribeiro on 01/04/24.
//

import Foundation


class ArticlesPresenter {
    
    var model: ArticlesModel?
    var service: DataProvider
    
    init(service: DataProvider = DataProvider()) {
        self.service = service
        fetchArticles()
    }
    
    func fetchArticles() {
        Task {
            do {
                let result: ArticlesModel = try await service.fetchAllArticles()
                self.model = result
            } catch {
                print(error)
            }
        }
    }
}
