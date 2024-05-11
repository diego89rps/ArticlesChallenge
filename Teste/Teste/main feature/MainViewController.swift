//
//  ViewController.swift
//  Teste
//
//  Created by Diego Ribeiro on 01/04/24.
//

import UIKit

class MainViewController: BaseViewController {
    lazy var customView: MainView = {
        let mainView = MainView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    let presenter: MainPresenter
    
    init(presenter: MainPresenter) {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
