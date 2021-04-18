//
//  OrdersRepositoryIntegrationTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 16/04/21.
//

import XCTest
@testable import cora

class OrdersRepositoryIntegrationTests: XCTestCase {
    var ordersDataSource: OrdersDataSource!
    var ordersRepository: OrdersRepository!
    
    let timeout = 120.0

    override func setUp() {
        super.setUp()
        ordersDataSource = OrdersDataSource()
        ordersRepository = OrdersRepository(ordersDataSource: ordersDataSource)
    }
    
    func test_integration_orders_repository_with_data_sources() {
        let ordersExpectation = XCTestExpectation(description: "waiting orders reponse")
        
        self.ordersRepository.fetchOrders() { result in
            let orders = try? result.get()
            XCTAssertNotNil(orders)
            XCTAssertTrue(orders!.count > 0)
            ordersExpectation.fulfill()
        }
        
        self.wait(for: [ordersExpectation], timeout: timeout)
    }
}

