//
//  LoginCoordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import Foundation
import UIKit

class LoginCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parent: Coordinator?
    var navigationController: NavigationController

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.isNavigationBarHidden = false
        navigationController.setNavigationAppearence(color: .black)
        navigationController.pushViewController(loginVC, animated: true)
    }

    func addAnother() {
        let viewC = ViewControllerCoordinator(navigationController: navigationController)
        self.addChild(viewC)
        viewC.start()
    }
}
