//
//  BaseViewCode.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//

import UIKit

public protocol BaseViewCode {
    func setupView()
    func setupSubviews()
    func setupConstraints()
}

extension BaseViewCode {
    func setupView() {
        setupSubviews()
        setupConstraints()
    }
    
    func createLabel(size: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: size)
        label.textColor = color
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
}
