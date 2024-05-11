//
//  BaseViewController.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//

import UIKit

open class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView
    
    init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.backgroundColor = .white
        activityIndicator.hidesWhenStopped = true
        super.init(nibName: nil, bundle: nil)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        view.backgroundColor = .white
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createNavBar(title: String, leftButton: UIBarButtonItem?, 
                      rightButton: UIBarButtonItem?) {
        self.title = title
        
        if let leftButton = leftButton {
            navigationItem.leftBarButtonItem = leftButton
        }
        
        if let rightButton = rightButton {
            navigationItem.rightBarButtonItem = rightButton
        }
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func callAlert(title: String, description: String, 
                   primaryAction: UIAlertAction, secondaryAction: UIAlertAction?) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        alert.addAction(primaryAction)
        
        if let action = secondaryAction {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loading(isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        } else {
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func openURL(url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
