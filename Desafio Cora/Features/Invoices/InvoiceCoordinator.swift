//
//  InvoicesCoordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 13/05/22.
//

import UIKit

protocol InvoiceCoordinatorDelegate: AnyObject {
    func getInvoiceData(data: InvoiceModel)
}

class InvoiceCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parent: Coordinator?
    var navigationController: NavigationController
    
    weak var networkServices: NetworkCoordinator?

    init(navigationController: NavigationController, networkServices: NetworkCoordinator?) {
        self.navigationController = navigationController
        self.networkServices = networkServices
    }

    func start() {
        let invoiceVC = InvoiceViewController()
        invoiceVC.coordinator = self
        navigationController.viewControllers = [invoiceVC]
        navigationController.navigationBar.backgroundColor = .red
    }

    func getInvoiceData(onSuccess: @escaping (InvoiceModel) -> Void, onFailure: ((Error) -> Void)?) {
        networkServices?.getInvoiceInfo(onSuccess: { result in
            onSuccess(result)
        }, onFailure: { _ in
            self.showAlert(title: "Error", message: "Error")
        })
    }
}
