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
    var navigationController: NavigationController
    private weak var networkServices: NetworkCoordinator?
    
    init(navigationController: NavigationController, networkServices: NetworkCoordinator?) {
        self.navigationController = navigationController
        self.networkServices = networkServices
    }

    func start() {
        let introVC = IntroViewController()
        introVC.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.setNavigationAppearence(color: .gray2)
        navigationController.pushViewController(introVC, animated: true)
    }

    func goToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, networkServices: networkServices)
        self.addChild(loginCoordinator)
        loginCoordinator.start()
    }
}
