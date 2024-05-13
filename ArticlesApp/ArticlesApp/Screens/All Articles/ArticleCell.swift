//
//  ArticleCell.swift
//  Teste
//
//  Created by Diego Ribeiro on 11/05/24.
//

import UIKit

class ArticleCell: UITableViewCell, BaseViewCode {
    
    // MARK: - Properties
    
    var identifier: String?
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 113).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 63).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var authorLabel: UILabel = createLabel(color: .lightGray,
                                                style: .subheadline)
    
    lazy var titleLabel: UILabel = createLabel(color: .black,
                                               style: .headline)
    
    lazy var descriptionLabel: UILabel = createLabel(color: .darkGray)
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func setupSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: posterImageView.bottomAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 16),

            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)

        ])
    }
}
