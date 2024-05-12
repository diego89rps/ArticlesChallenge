//
//  Coordinator.swift
//  Teste
//
//  Created by Diego Ribeiro on 11/05/24.
//

import UIKit

class Coordinator {
    
    var navigation: UINavigationController?
    
    func start() -> UIViewController? {
        let presenter = ArticlesPresenter()
        let controller = ArticlesViewController(presenter: presenter)
        self.navigation = UINavigationController(rootViewController: controller)
        return self.navigation
    }
    
    func goToDetails(isTimedMode: Bool) {

//        self.navigation?.pushViewController(controller, animated: true)
    }
    
    func goBack() {
        self.navigation?.popViewController(animated: true)
    }
    
}
