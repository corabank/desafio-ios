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
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }

    func addAnother() {
        let viewC = ViewControllerCoordinator(navigationController: navigationController)
        self.addChild(viewC)
        viewC.start()
    }
}
