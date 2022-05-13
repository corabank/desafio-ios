//
//  PasswordCoordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 13/05/22.
//

import Foundation
import UIKit

class PasswordCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parent: Coordinator?
    var navigationController: NavigationController

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let passwordVC = PasswordViewController()
        passwordVC.coordinator = self
        navigationController.pushViewController(passwordVC, animated: true)
    }

    func goToInvoice() {
        let invoiceC = InvoiceCoordinator(navigationController: navigationController)
        addChild(invoiceC)
        invoiceC.start()
    }
}
