//
//  HomeViewController.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 12/03/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    private let homeView: HomeView = {
        let homeView = HomeView()
        return homeView
    }()
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
    }
        
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeView.signinButton.addTarget(self, action: #selector(showLoginScreen), for: .touchUpInside)
        homeView.setCornerRadius()
    }
    
    @objc func showLoginScreen() {
        homeView.signinButton.backgroundColor = .white
        let login = LoginViewController()
        navigationController?.pushViewController(login, animated: true)
    }
}
