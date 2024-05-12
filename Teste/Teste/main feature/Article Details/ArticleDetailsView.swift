//
//  ArticleDetailsView.swift
//  Teste
//
//  Created by Diego Ribeiro on 12/05/24.
//

import UIKit

class ArticleDetailsView: BaseView, BaseViewCode {
    
    // MARK: Properties
    
    var buttonAction: (() -> Void)?
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var publishedAtLabel: UILabel = createLabel(size: 12, color: .lightGray)
    
    lazy var contentLabel: UILabel = createLabel(size: 12, color: .black)
    
    lazy var readMoreBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.setTitle("Tap to read more", for: .normal)
        return button
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
        container.addSubview(posterImageView)
        container.addSubview(publishedAtLabel)
        container.addSubview(contentLabel)
        container.addSubview(readMoreBtn)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 24),
            posterImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            publishedAtLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            publishedAtLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            publishedAtLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: publishedAtLabel.bottomAnchor, constant: 12),
            contentLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            readMoreBtn.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 12),
            readMoreBtn.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            readMoreBtn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            readMoreBtn.bottomAnchor.constraint(greaterThanOrEqualTo: container.bottomAnchor, constant: -24),
        ])
    }
    
    @objc func buttonTapped() {
        buttonAction?()
    }
}
