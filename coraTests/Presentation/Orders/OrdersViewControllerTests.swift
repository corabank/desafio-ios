//
//  OrdersViewControllerTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 20/04/21.
//

import XCTest

import XCTest
@testable import cora

class OrdersViewControllerTests: XCTestCase {

    var ordersViewController: OrdersViewController!
    let viewModel = OrdersViewModelProtocolMock()
    let coordinator = OrdersViewControllerDelegateMock()

    override func setUp() {
        super.setUp()

        ordersViewController = OrdersViewController()
        ordersViewController.tableView = .init()

        ordersViewController.delegate = coordinator
        ordersViewController.viewModel = viewModel

        ordersViewController.viewDidLoad()
        ordersViewController.viewWillAppear(false)
    }
    

    func testWhenOrdersLoading() throws {
        viewModel.onUpdated?(.loading)
//        XCTAssertEqual(loginViewController.load.text, "O email é obrigatório")
    }
    
    func testWhenOrdersHasFailure() throws {
        viewModel.onUpdated?(.failure)
//        XCTAssertEqual(loginViewController.load.text, "O email é obrigatório")
    }
    
    func testWhenOrdersAreLoaded() throws {
        let orders = OrdersFactory.create()
        viewModel.onUpdated?(.success(orders: orders))
        XCTAssert(ordersViewController.orders.count > 0)
        XCTAssertEqual(ordersViewController.orders.count, orders.count)
    }
}
