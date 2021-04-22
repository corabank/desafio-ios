//
//  OrdersUseCaseTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 16/04/21.
//

import XCTest
import SwiftyMocky
@testable import cora

class OrdersUseCaseTests: XCTestCase {

    var user: User!
    var orders: [Order]!
    var ordersRepository: OrdersRepositoryProtocolMock!
    var ordersPresenter: OrdersPresenterMock!

    var useCase: OrdersUseCase!

    override func setUp() {
        super.setUp()

        self.user = User.init(id: UUID(), name: "John Due", email: "john@due.com")
        self.orders = OrdersFactory.create()
        self.ordersRepository = OrdersRepositoryProtocolMock()
        self.ordersPresenter = OrdersPresenterMock()
        self.useCase = OrdersUseCase(repository: ordersRepository)
        useCase.presenter = ordersPresenter
    }

    fileprivate func ordersRepositoryPerfomOrders() {
        ordersRepository.perform(
            .fetchOrders(userID: .any, completionHandler: .any, perform: { (userID, completionHandler) in
                completionHandler(.success(self.orders))
            })
        )
    }

    func test_orders_use_case_should_return_a_list_of_orders() throws {
        ordersRepositoryPerfomOrders()
        useCase.run(userID: user.id)
        ordersPresenter.verify(.loading())
        ordersPresenter.verify(.success(orders: .any))
        ordersRepository.verify(.fetchOrders(userID: .any, completionHandler: .any))
    }

    func test_orders_should_return_failure() {
        ordersRepository.perform(
            .fetchOrders(
                userID: .any, completionHandler: .any,
                perform: { (userID, completionHandler) in
                    completionHandler(.failure(URLError(.unknown)))
                }
            )
        )

        
        useCase.run(userID: user.id)

        ordersPresenter.verify(.loading())
        ordersPresenter.verify(.failure())
        ordersPresenter.verify(.failure(), count: 1)
        ordersRepository.verify(.fetchOrders(userID: .any, completionHandler: .any))
    }
}
