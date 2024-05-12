//
//  ViewController.swift
//  Teste
//
//  Created by Diego Ribeiro on 01/04/24.
//

import UIKit

class ArticlesViewController: BaseViewController {
    
    // MARK: Properties
    
    lazy var customView: ArticlesView = {
        let mainView = ArticlesView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    let presenter: ArticlesPresenter
    
    // MARK: Initialization
    
    init(presenter: ArticlesPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(customView)
        customView.insertIntoSuperView(superView: self.view)
        createNavBar(title: "Articles")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.tableView.register(ArticleCell.self, forCellReuseIdentifier: "CustomCell")
        
        presenter.viewDelegate = self
        presenter.fetchArticles()
    }

}

// MARK: - ArticlesPresenterViewDelegate

extension ArticlesViewController: ArticlesPresenterViewDelegate {
    func reloadTableView() {
        self.customView.tableView.reloadData()
    }
    
    func loadingView(isLoading: Bool) {
        loading(isLoading: isLoading)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! ArticleCell
        
        cell.authorLabel.text = presenter.articleAuthor(at: indexPath.row)
        cell.titleLabel.text = presenter.articleTitle(at: indexPath.row)
        cell.descriptionLabel.text = presenter.articleDescription(at: indexPath.row)
        
        if let posterPath = presenter.articlePosterPath(at: indexPath.row) {
            Task {
                do {
                    let imageData = await presenter.downloadImage(posterURL: posterPath, index: indexPath.row)
                    if let imageData = imageData, let image = UIImage(data: imageData) {
                        DispatchQueue.main.async  {
                            cell.posterImageView.image = image
                            cell.setNeedsLayout()
                        }
                    }
                }
            }
        }
                
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       presenter.goToDetails(index: indexPath.row)
    }
}
