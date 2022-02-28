//
//  TransactionsListFactory.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

enum TransactionsListFactory {
    static func make() -> TransactionsListViewController {
        let coordinator = TransactionsListCoordinator()
        let presenter = TransactionsListPresenter(coordinator: coordinator)
        let service = MockedTransactionsListService() //TransactionsListService
        let interactor = TransactionsListInteractor(service: service, presenter: presenter)
        let viewController = TransactionsListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
