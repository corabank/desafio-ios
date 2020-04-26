//
//  OrderRepositoryTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import RogueKit
@testable import DesafioCoraBank

class OrderRepositoryTests: XCTestCase {
    
    private var requestPromise: XCTestExpectation?
    
    func testValidEntityOnFetchOrderList() {
        requestPromise = expectation(description: "Should fail due to invalid entity")
        
        RogueKit.request(OrderRepository.fetchOrderList, enableMocks: true) { (result: Result<OrderListEntity, Error>) in
            if case .success(_) = result {
                self.requestPromise?.fulfill()
            }
        }
        
        self.wait(for: [self.requestPromise!], timeout: 60)
    }
    
    func testValidEntityOnFetchOrder() {
        requestPromise = expectation(description: "Should fail due to invalid entity")
        
        RogueKit.request(OrderRepository.fetchOrder(orderID: "1"), enableMocks: true) { (result: Result<OrderEntity, Error>) in
            if case .success(_) = result {
                self.requestPromise?.fulfill()
            }
        }
        
        self.wait(for: [self.requestPromise!], timeout: 60)
    }

    func testRequestInvalidFetchOrderListRequest() {
        requestPromise = expectation(description: "Should fail due to invalid endpoint")
        
        RogueKit.request(OrderRepository.fetchOrderList) { (result: Result<OrderListEntity, Error>) in
            if case .failure = result {
                self.requestPromise?.fulfill()
            }
        }
        
        self.wait(for: [self.requestPromise!], timeout: 60)
    }
    
    func testRequestInvalidFetchOrderRequest() {
        requestPromise = expectation(description: "Should fail due to invalid endpoint")
        
        RogueKit.request(OrderRepository.fetchOrder(orderID: "1")) { (result: Result<OrderEntity, Error>) in
            if case .failure = result {
                self.requestPromise?.fulfill()
            }
        }
        
        self.wait(for: [self.requestPromise!], timeout: 60)
    }
    
    func testInvalidEntityOnFetchOrderList() {
        requestPromise = expectation(description: "Should fail due to invalid entity")
        
        RogueKit.request(OrderRepository.fetchOrderList, enableMocks: true) { (result: Result<UserEntity, Error>) in
            if case .failure = result {
                self.requestPromise?.fulfill()
            }
        }
        
        self.wait(for: [self.requestPromise!], timeout: 60)
    }
    
    func testInvalidEntityOnFetchOrder() {
        requestPromise = expectation(description: "Should fail due to invalid entity")
        
        RogueKit.request(OrderRepository.fetchOrder(orderID: "1"), enableMocks: true) { (result: Result<UserEntity, Error>) in
            if case .failure = result {
                self.requestPromise?.fulfill()
            }
        }
        
        self.wait(for: [self.requestPromise!], timeout: 60)
    }
}
