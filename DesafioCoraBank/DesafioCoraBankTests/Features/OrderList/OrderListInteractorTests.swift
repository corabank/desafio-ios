//
//  OrderListInteractorTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class OrderListInteractorTests: XCTestCase {
    
    private var interactor: OrderListInteractor!
    
    private let timeout = 10.0
    private var fetchListPromise: XCTestExpectation?
    private var failurePromise: XCTestExpectation?
    
    override func setUp() {
        interactor = OrderListInteractor(enableMocks: true)
        interactor.setPresenter(self)
    }
    
    override func tearDown() {
        interactor = nil
    }
    
    func testFetchOrderList() {
        fetchListPromise = expectation(description: "Should be able to fetch a list of orders.")
        self.interactor.fetchOrderList()
        self.wait(for: [self.fetchListPromise!], timeout: timeout)
    }
    
    func testRequestFailure() {
        failurePromise = expectation(description: "Should fail the request.")
        let failureInteractor = OrderListInteractor(enableMocks: false)
        failureInteractor.setPresenter(self)
        failureInteractor.fetchOrderList()
        self.wait(for: [self.failurePromise!], timeout: timeout)
    }
}

extension OrderListInteractorTests: OrderListPresenterProtocol {
    func processOrders(entity: OrderListEntity?) {
        
        guard entity != nil else {
            failurePromise?.fulfill()
            return
        }
        
        XCTAssertNotNil(entity, "Should have an entity.")
        XCTAssertGreaterThan(entity?.orderCount ?? 0, 1, "Should have at least one order.")
        XCTAssertGreaterThan(entity?.orderTotalValue ?? 0, 0, "Total value should be grater than 0.")
        XCTAssertNotNil(entity?.orderList, "Should have a list of orders.")
        XCTAssertFalse(entity?.orderList?.isEmpty ?? true, "The list should not be empty.")
        let order = entity!.orderList!.first!
        XCTAssertNotNil(order.id, "The Order should have a valid id.")
        XCTAssertNotNil(order.value, "The Order should have a valid value.")
        XCTAssertNotNil(order.email, "The Order should have a valid email.")
        XCTAssertNotNil(order.status, "The Order should have a valid status.")
        XCTAssertNotNil(order.date, "The Order should have a valid date.")
        
        XCTAssertGreaterThan(entity!.orderList!.count, 2, "Should have more than two orders on array")
        let order2 = entity!.orderList![1]
        XCTAssertTrue(order.date!.compare(order2.date!) == .orderedDescending, "The dates should be in correct order.")
        
        for (index, order) in entity!.orderList!.enumerated() {
            print("Data[\(index)]: \(order.date?.friendlyDescription() ?? "No date")")
        }
        
        fetchListPromise?.fulfill()
    }
    
    func setView(_ abstractView: DKAbstractView) {}
}
