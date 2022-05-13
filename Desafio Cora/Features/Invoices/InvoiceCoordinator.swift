//
//  InvoicesCoordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 13/05/22.
//

import UIKit

class InvoiceCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parent: Coordinator?
    var navigationController: NavigationController

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let invoiceVC = InvoiceViewController()
        invoiceVC.coordinator = self
        navigationController.viewControllers = [invoiceVC]
        navigationController.navigationBar.backgroundColor = .red
    }
}
