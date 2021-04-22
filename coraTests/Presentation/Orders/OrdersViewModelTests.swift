//
//  OrdersViewModelTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 20/04/21.
//

import XCTest

import XCTest
import SwiftyMocky
@testable import cora

class OrdersViewModelTests: XCTestCase {

    let useCase = OrdersUseCaseProtocolMock()
    var viewModel: OrdersViewModel!

    override func setUp() {
        super.setUp()
        let user = User(name: "John Due", email: "john.due@mail.com")
        State.shared.user = user
        viewModel = OrdersViewModel(useCase: useCase)
        useCase.given(.presenter(getter: viewModel))
    }


    func testOrdersWhenuseCaseReturnsLoading() throws {

        useCase.perform(.run(userID: .any, perform: { _ in
            self.useCase.presenter?.loading()
        }))

        viewModel.fetchOrders()

        XCTAssertEqual(viewModel.state, OrdersViewModelState.loading)
    }
    
    func testOrdersWhenuseCaseReturnsSuccessWithOrders() throws {

        let orders = OrdersFactory.create()
        useCase.perform(.run(userID: .any, perform: { uuid in
            self.useCase.presenter?.success(orders: orders)
        }))

        viewModel.fetchOrders()

        XCTAssertEqual(viewModel.state, OrdersViewModelState.success(orders: orders))
    }
    
    func testOrdersWhenuseCaseReturnsFailure() throws {

        useCase.perform(.run(userID: .any, perform: { uuid in
            self.useCase.presenter?.failure()
        }))

        viewModel.fetchOrders()

        XCTAssertEqual(viewModel.state, OrdersViewModelState.failure)
    }
}
