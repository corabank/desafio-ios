//
//  IntroCoordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import UIKit

class IntroCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parent: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let introVC = IntroViewController()
        introVC.coordinator = self
        navigationController.pushViewController(introVC, animated: true)
    }

    func goToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        self.addChild(loginCoordinator)
        loginCoordinator.start()
    }
}
