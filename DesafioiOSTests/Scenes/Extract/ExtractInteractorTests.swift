//
//  ExtractInteractorTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class ExtractInteractorTests: XCTestCase {

    let serviceSpy = ExtractServiceSpy()
    let presenterSpy = ExtractPresenterSpy()
    lazy var sut = ExtractInteractor(service: serviceSpy, presenter: presenterSpy)
    
    override func setUp() {
        super.setUp()
        sut.fetch()
    }
    
    func test_getTransactionType() {
        var result = sut.getTransactionType(filterType: .all)
        XCTAssertEqual(result, TransactionType.allCases)
        
        result = sut.getTransactionType(filterType: .entry)
        XCTAssertEqual(result, [.entry])
        
        
        result = sut.getTransactionType(filterType: .output)
        XCTAssertEqual(result, [.output])
        
        result = sut.getTransactionType(filterType: .future)
        XCTAssertEqual(result, [.refund])
    }
    
    func test_countTransactions() {
        let result = sut.countTransactions(indexPath: .init(row: 0, section: 0))
        XCTAssertEqual(result, 3)
    }
    
    func test_didTapTransaction() {
        sut.didTapTransaction()
        XCTAssertTrue(presenterSpy.presentReceiptCalled)
    }
    
    func test_getHeaderTransaction() {
        let result = sut.getHeaderTransaction(section: 0)
        XCTAssertEqual(result.balance, "3050.30")
        XCTAssertEqual(result.day, "Hoje - 6 de Agosto")
    }
    
    func test_filterTransaction() {
        sut.filterTransaction(type: .entry)
        XCTAssertEqual(sut.filterModel?.days.count, 3)
        XCTAssertTrue(presenterSpy.presentExtractCalled)
        
        sut.filterTransaction(type: .all)
        XCTAssertEqual(sut.filterModel?.days.count, 4)
        
        sut.filterTransaction(type: .future)
        XCTAssertEqual(sut.filterModel?.days.count, 4)
        
        sut.filterTransaction(type: .output)
        XCTAssertEqual(sut.filterModel?.days.count, 1)
    }
    
    func test_getCellModel() {
        let result = sut.getCellModel(index: .init(row: 0, section: 0))
        XCTAssertEqual(result.name, "Lucas Costa")
        XCTAssertEqual(result.description, "Transferência recebida")
        XCTAssertEqual(result.time, "17:35")
        XCTAssertEqual(result.value, "R$ 30,00")
    }
    
    func test_numberOfRows() {
        let result = sut.numberOfRows(section: 0)
        XCTAssertEqual(result, 4)
    }
    
    func test_numberOfSection() {
        let result = sut.numberOfSection()
        XCTAssertEqual(result, 4)
    }
    
    func test_fetch() {
        sut.fetch()
        XCTAssertTrue(presenterSpy.presentExtractCalled)
    }
}
