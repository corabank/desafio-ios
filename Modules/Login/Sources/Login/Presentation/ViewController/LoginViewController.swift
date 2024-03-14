//
//  LoginViewController.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import UIKit
import Core

class LoginViewController: UIViewController, PresentableLoginView {
    
    private var viewModel: LoginViewModelProtocol
    private var navigationService: LoginNavigationService?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.Login.backgroundImage
        return imageView
    }()
    
    init(viewModel: LoginViewModelProtocol, navigationService: LoginNavigationService) {
        self.viewModel = viewModel
        self.navigationService = navigationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    private func prepareView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
