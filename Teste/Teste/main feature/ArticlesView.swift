//
//  MainView.swift
//  Teste
//
//  Created by Diego Ribeiro on 02/04/24.
//

import UIKit

class ArticlesView: BaseView, BaseViewCode {
    
    // MARK: Properties
    

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

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

        ])
    }
}
