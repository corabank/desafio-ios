//
//  OrdersUseCase.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

public enum OrdersUseCaseError: Error {
    case empty
}

//sourcery: AutoMockable
protocol OrdersUseCaseProtocol {
    var presenter: OrdersPresenter? { get set }
    func run(userID: UUID)
}

class OrdersUseCase: OrdersUseCaseProtocol {
    var presenter: OrdersPresenter?
    let repository: OrdersRepositoryProtocol

    init(repository: OrdersRepositoryProtocol) {
        self.repository = repository
    }

    func run(userID: UUID) {

        // starts loading
        self.presenter?.loading()

        // request to repository fetch orders
        self.repository.fetchOrders(userID: userID) { result in
            do {
                let orders = try result.get()
                self.presenter?.success(orders: orders)
            } catch {
                self.presenter?.failure()
            }
        }
    }
}
