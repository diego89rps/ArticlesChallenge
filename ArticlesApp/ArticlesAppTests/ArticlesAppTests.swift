//
//  ArticlesAppTests.swift
//  ArticlesAppTests
//
//  Created by Diego Ribeiro on 12/05/24.
//

import XCTest
@testable import ArticlesApp

final class ArticlesPresenterTests: XCTestCase {
    
    class MockDataProvider: DataProviderProtocol {
        func fetchAllArticles() async throws -> ArticlesModel {
            let article = Article(author: "Jazz Monroe", title: "Charli XCX ",
                                  description: "A committee of ",
                                  url: "https://pitchfor",
                                  urlToImage: "https://media.",
                                  publishedAt: "2024-05-10T14:06:19Z",
                                  content: "Charli XCX has enlisted ")
            return ArticlesModel(articles: [article])
        }
        
        func fetchImageData(imageURLString: String) async throws -> Data {
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
    
    func testNumberOfArticles() {
        XCTAssertEqual(presenter.numberOfArticles, 0)
    }
    
    @MainActor func testFetchArticles() {
        let reloadExpectation = expectation(description: "reloadTableViewCalled")
        mockViewDelegate.reloadTableViewExpectation = reloadExpectation
        
        presenter.fetchArticles()
        XCTAssertTrue(mockViewDelegate.isLoadingCalled)
        mockViewDelegate.isLoadingCalled = false
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Timeout")
            XCTAssertTrue(self.mockViewDelegate.isLoadingCalled)
            XCTAssertEqual(self.presenter.numberOfArticles, 1)
        }
    }
    
    func testGoToDetails() {
        let article = Article(author: "Test Author",
                              title: "Test Title",
                              description: "Test Description",
                              url: "https://testurl.com",
                              urlToImage: "https://testimageurl.com",
                              publishedAt: "2024-05-12T00:00:00Z",
                              content: "Test Content")
        
        presenter.articlesList = ArticlesModel(articles: [article])
        
        presenter.goToDetails(index: 0)
        
        XCTAssertTrue(mockCoordinatorDelegate.goToDetailViewCalled)
        
        XCTAssertEqual(mockCoordinatorDelegate.article?.author, "Test Author")
        XCTAssertEqual(mockCoordinatorDelegate.article?.title, "Test Title")
        XCTAssertEqual(mockCoordinatorDelegate.article?.description, "Test Description")
        XCTAssertEqual(mockCoordinatorDelegate.article?.url, "https://testurl.com")
        XCTAssertEqual(mockCoordinatorDelegate.article?.urlToImage, "https://testimageurl.com")
        XCTAssertEqual(mockCoordinatorDelegate.article?.publishedAt, "2024-05-12T00:00:00Z")
        XCTAssertEqual(mockCoordinatorDelegate.article?.content, "Test Content")
        XCTAssertEqual(mockCoordinatorDelegate.poster, nil)
    }

}

//MARK: - Mock TO ArticlesPresenterViewDelegate
class MockArticlesPresenterViewDelegate: ArticlesPresenterViewDelegate {
    var isLoadingCalled = false
    var reloadTableViewExpectation: XCTestExpectation?
    
    func reloadTableView() {
        reloadTableViewExpectation?.fulfill()
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
