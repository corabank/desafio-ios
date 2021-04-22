//
//  OrdersRepositoryTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 16/04/21.
//

import XCTest
import SwiftyMocky
@testable import cora

class OrdersRepositoryTests: XCTestCase {
    var ordersDTO: [OrderDTO] = []

    var ordersDataSource: OrdersDataSourceProtocolMock!
    var ordersRepository: OrdersRepository!
    
    override func setUp() {
        super.setUp()
        
        ordersDTO = OrdersFactory.createDTO()
        ordersDataSource = OrdersDataSourceProtocolMock()
        ordersRepository = OrdersRepository(dataSource: ordersDataSource)
    }
    
    func fetchOrders() throws -> [Order]? {
        var result: Result<[Order], Error>?
        ordersRepository.fetchOrders(userID: UUID()) { result = $0 }
        return try result?.get()
    }
    
    func test_orders_repository_with_dto_should_return_orders() throws {
        ordersDataSource.perform(
            .fetchOrders(
                userID: .any, completionHandler: .any,
                perform: { (userID, completionHandler) in
                    completionHandler(.success(self.ordersDTO))
        }))
        
        let orders = try fetchOrders()
        
        XCTAssertEqual(orders?.count, 100)
        ordersDataSource.verify(.fetchOrders(userID: .any, completionHandler: .any))
    }
    
    func test_orders_repository_should_return_error() throws {
        ordersDataSource.perform(
            .fetchOrders(
                userID: .any,
                completionHandler: .any,
                perform: { (userID, completionHandler) in
                    completionHandler(.failure(URLError(.unknown)))
        }))

        XCTAssertThrowsError(try fetchOrders())
        ordersDataSource.verify(.fetchOrders(userID: .any, completionHandler: .any))
    }
}
