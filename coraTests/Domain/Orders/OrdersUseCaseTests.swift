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

    var orders: [Order]!
    var ordersRepository: OrdersRepositoryProtocolMock!
    var ordersPresenter: OrdersPresenterMock!

    var useCase: OrdersUseCase!

    override func setUp() {
        super.setUp()

        self.orders = OrdersFactory.create()
        self.ordersRepository = OrdersRepositoryProtocolMock()
        self.ordersPresenter = OrdersPresenterMock()
        self.useCase = OrdersUseCase(repository: ordersRepository)
        useCase.presenter = ordersPresenter
    }

    fileprivate func ordersRepositoryPerfomOrders() {
        ordersRepository.perform(
            .fetchOrders(
                completionHandler: .any,
                perform: { completionHandler in
                    completionHandler(.success(self.orders))
                }
            )
        )
    }

    func test_orders_use_case_should_return_a_list_of_orders() throws {
        ordersRepositoryPerfomOrders()
        useCase.execute()
        ordersPresenter.verify(.loading())
        ordersPresenter.verify(.success(orders: .any))
        ordersRepository.verify(.fetchOrders(completionHandler: .any))
    }

    func test_orders_should_return_failure() {
        ordersRepository.perform(
            .fetchOrders(
                completionHandler: .any,
                perform: { completionHandler in
                    completionHandler(.failure(URLError(.unknown)))
                }
            )
        )

        useCase.execute()

        ordersPresenter.verify(.loading())
        ordersPresenter.verify(.failure())
        ordersPresenter.verify(.failure(), count: 1)
        ordersRepository.verify(.fetchOrders(completionHandler: .any))
    }
}
