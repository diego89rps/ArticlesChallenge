//
//  ArticlesAppTests.swift
//  ArticlesAppTests
//
//  Created by Diego Ribeiro on 12/05/24.
//

import XCTest
@testable import ArticlesApp

final class ArticlesPresenterTests: XCTestCase {
    
    class MockDataProvider: DataProvider {
        override func fetchAllArticles() async throws -> ArticlesModel {
            return ArticlesModel(articles: [])
        }
        
        override func fetchImageData(imageURLString: String) async throws -> Data {
            return Data()
        }
    }
    
    var presenter: ArticlesPresenter!
    var mockViewDelegate: MockArticlesPresenterViewDelegate!
    var mockCoordinatorDelegate: MockArticlesPresenterCoordinatorDelegate!
    
    override func setUp() {
        super.setUp()
        let mockService = MockDataProvider()
        presenter = ArticlesPresenter(service: mockService)
        mockViewDelegate = MockArticlesPresenterViewDelegate()
        mockCoordinatorDelegate = MockArticlesPresenterCoordinatorDelegate()
        presenter.viewDelegate = mockViewDelegate
        presenter.coordinatorDelegate = mockCoordinatorDelegate
    }
    
    @MainActor func testFetchArticles() {
        presenter.fetchArticles()
        XCTAssertTrue(mockViewDelegate.isLoadingCalled)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            XCTAssertTrue(self.mockViewDelegate.reloadTableViewCalled)
            XCTAssertTrue(self.mockViewDelegate.isLoadingCalled)
        })

    }
    
    func testNumberOfArticles() {
        XCTAssertEqual(presenter.numberOfArticles, 0) // Deve ser 0 inicialmente
        presenter.articlesList = ArticlesModel(articles: [])
        XCTAssertEqual(presenter.numberOfArticles, 0)
    }
    
}

//MARK: - Mock TO ArticlesPresenterViewDelegate
class MockArticlesPresenterViewDelegate: ArticlesPresenterViewDelegate {
    var isLoadingCalled = false
    var reloadTableViewCalled = false
    
    func reloadTableView() {
        reloadTableViewCalled = true
    }
    
    func loadingView(isLoading: Bool) {
        isLoadingCalled = true
    }
}

//MARK: - Mock TO ArticlesPresenterCoordinatorDelegate
class MockArticlesPresenterCoordinatorDelegate: ArticlesPresenterCoordinatorDelegate {
    var goToDetailViewCalled = false
    var article: Article?
    var poster: Data?
    
    func goToDetailView(article: Article, poster: Data?) {
        goToDetailViewCalled = true
        self.article = article
        self.poster = poster
    }
}
