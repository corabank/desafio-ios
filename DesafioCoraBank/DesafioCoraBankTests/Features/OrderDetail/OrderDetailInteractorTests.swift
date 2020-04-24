//
//  OrderDetailInteractorTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class OrderDetailInteractorTests: XCTestCase {
    
    private var interactor: OrderDetailInteractor!
    
    private let timeout = 10.0
    private var fetchOrderPromise: XCTestExpectation?
    private var failurePromise: XCTestExpectation?
    
    override func setUp() {
        interactor = OrderDetailInteractor(enableMocks: true)
        interactor.setPresenter(self)
    }
    
    override func tearDown() {
        interactor = nil
    }
    
    func testFetchOrderList() {
        fetchOrderPromise = expectation(description: "Should be able to fetch a list of orders.")
        self.interactor.fetchOrderDetail(orderID: "abcdef123")
        self.wait(for: [self.fetchOrderPromise!], timeout: timeout)
    }
    
    func testRequestFailure() {
        failurePromise = expectation(description: "Should fail the request.")
        let failureInteractor = OrderDetailInteractor(enableMocks: false)
        failureInteractor.setPresenter(self)
        failureInteractor.fetchOrderDetail(orderID: "abcdef123")
        self.wait(for: [self.failurePromise!], timeout: timeout)
    }
}

extension OrderDetailInteractorTests: OrderDetailPresenterProtocol {
    
    func processOrder(entity: OrderEntity?) {
        
        guard entity != nil else {
            failurePromise?.fulfill()
            return
        }
        
        XCTAssertNotNil(entity, "Should have a valid order.")
        let order = entity!
        XCTAssertNotNil(order.id, "The Order should have a valid id.")
        XCTAssertNotNil(order.value, "The Order should have a valid value.")
        XCTAssertNotNil(order.email, "The Order should have a valid email.")
        XCTAssertNotNil(order.status, "The Order should have a valid status.")
        XCTAssertNotNil(order.date, "The Order should have a valid date.")
        XCTAssertNotNil(order.paymentMethod, "The Order should have a valid payment type.")
        XCTAssertNotNil(order.buyerName, "The Order should have a valid buyer name.")
        XCTAssertNotNil(order.taxes, "The Order should have valid taxes.")
        XCTAssertNotNil(order.sandbox, "The Order should have a valid sandbox.")
        fetchOrderPromise?.fulfill()
    }
    
    func setView(_ abstractView: DKAbstractView) {}
}
