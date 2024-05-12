//
//  ArticleDetailsViewController.swift
//  Teste
//
//  Created by Diego Ribeiro on 12/05/24.
//

import UIKit

class ArticleDetailsViewController: BaseViewController {
    
    // MARK: Properties
    
    lazy var customView: ArticleDetailsView = {
        let mainView = ArticleDetailsView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    let presenter: ArticleDetailsPresenter
    
    // MARK: Initialization
    
    init(presenter: ArticleDetailsPresenter) {
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
        createNavBar(title: "Details")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Methods
    
    func setupView() {
        customView.posterImageView.image = UIImage(data: presenter.poster ?? Data())
        customView.publishedAtLabel.text = presenter.dateFormated
        customView.contentLabel.text = presenter.article.content
        customView.buttonAction = {
            self.openURL(url: self.presenter.article.url)
        }
    }
    
    func setupNavBar() {
        let leftButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(leftButtonAction))
        createNavBar(title: "Details", leftButton: leftButton, rightButton: nil)
    }
    
    //MARK: - Events
    
    @objc func leftButtonAction() {
        presenter.goBack()
    }
}
