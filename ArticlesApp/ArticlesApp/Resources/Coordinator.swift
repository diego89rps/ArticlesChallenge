//
//  Coordinator.swift
//  Teste
//
//  Created by Diego Ribeiro on 11/05/24.
//

import UIKit

class Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = ArticlesPresenter()
        presenter.coordinatorDelegate = self
        let controller = ArticlesViewController(presenter: presenter)
        self.navigationController.pushViewController(controller, animated: true)
    }
    
}

// MARK: - ArticlesPresenterCoordinatorDelegate

extension Coordinator: ArticlesPresenterCoordinatorDelegate {
    func goToDetailView(article: Article, poster: Data?) {
        let presenter = ArticleDetailsPresenter(article: article, data: poster)
        presenter.coordinatorDelegate = self
        let controller = ArticleDetailsViewController(presenter: presenter)
        self.navigationController.pushViewController(controller, animated: true)
    }
}

extension Coordinator: ArticleDetailsPresenterCoordinatorDelegate {
    func goBack() {
        self.navigationController.popViewController(animated: true)
    }
}
