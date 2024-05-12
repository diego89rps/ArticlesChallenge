//
//  MainView.swift
//  Teste
//
//  Created by Diego Ribeiro on 02/04/24.
//

import UIKit

class ArticlesView: BaseView, BaseViewCode {
    
    // MARK: Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Methods
    
    func setupSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        container.removeFromSuperview()
        scrollView.removeFromSuperview()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
}
