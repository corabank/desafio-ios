//
//  LoginCoordinator.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit

class LoginCoordinator: Coordinator {    
    var childrens: [Coordinator] = []
    private let navigationController: UINavigationController

    required init(withNavigation navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let useCase = container.resolve(LoginUseCaseProtocol.self)!
        let loginViewModel = LoginViewModel(useCase: useCase)
        let loginViewController = LoginViewController()
        
        loginViewController.viewModel = loginViewModel
        loginViewController.delegate = self
        self.navigationController.viewControllers = [loginViewController]
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func authenticated() {
        let ordersCoordinator = OrdersCoordinator(withNavigation: navigationController)
        ordersCoordinator.start()
    }
}
