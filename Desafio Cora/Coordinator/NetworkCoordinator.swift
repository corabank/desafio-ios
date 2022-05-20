//
//  NetworkCoordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 18/05/22.
//

import UIKit

public class NetworkCoordinator: NSObject, Coordinator {
    public var childCoordinators: [Coordinator] = []
    public var parent: Coordinator?
    public var navigationController: NavigationController

    // MARK: Services
    private let invoiceService: InvoiceService

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
        invoiceService = InvoiceService()
    }

    public func start() {
        // call reachbility e.g
    }

    func getInvoiceInfo(onSuccess: @escaping (InvoiceModel) -> Void, onFailure: ((Error) -> Void)?) {
         onSuccess(invoiceService.loadData())
    }
}
