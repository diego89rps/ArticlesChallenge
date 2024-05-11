//
//  BaseView.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//
import UIKit

class BaseView: UIView {

    // MARK: Properties
    
    lazy var container: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()

    lazy var scrollView: UIScrollView = {
        let container = UIScrollView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.showsVerticalScrollIndicator = false
        container.showsHorizontalScrollIndicator = false
        container.bounces = false
        return container
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Methods
    
    func setupBaseView() {
        scrollView.addSubview(container)
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension BaseView {
    func insertIntoSuperView(superView: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
