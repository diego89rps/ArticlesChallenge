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
    
    func createLabel(color: UIColor,
                     style: UIFont.TextStyle = .body) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: style)
        label.textColor = color
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.minimumScaleFactor = 11
        return label
    }
}
