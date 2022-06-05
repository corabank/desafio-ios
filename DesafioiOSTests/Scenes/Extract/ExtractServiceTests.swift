//
//  ExtractServiceTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import XCTest
@testable import DesafioiOS

final class ExtractServiceTests: XCTestCase {
    let jsonManager = CoraJsonManager(fileName: "extract-transactions")
    lazy var sut = ExtractService(jsonManager: jsonManager)
    
    func test_fetch_withSuccess() {
        let expectation = expectation(description: "Wait fetch data")
        
        sut.fetch { result in
            switch result {
            case .success(let model):
                expectation.fulfill()
                XCTAssertEqual(model.days.count, 4)
            case .failure:
                expectation.fulfill()
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func test_fetch_withFailure() {
        let invalidJsonManager = CoraJsonManager(fileName: "invalid")
        let sut = ExtractService(jsonManager: invalidJsonManager)

        let expectation = expectation(description: "Wait fetch data")
        
        sut.fetch { result in
            switch result {
            case .success:
                expectation.fulfill()
                XCTFail()
            case .failure:
                expectation.fulfill()
                XCTAssertTrue(true)
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
