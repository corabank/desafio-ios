//
//  TransactionDetailsPresenterTests.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/27/22.
//

import XCTest
@testable import DesafioCora

class TransactionDetailsDisplaySpy: TransactionDetailsDisplaying {
    private(set) var displayTransactionCallCount = 0
    private(set) var displayedTransaction: TransactionModel?
    
    func displayTransaction(_ transaction: TransactionModel) {
        displayTransactionCallCount += 1
        displayedTransaction = transaction
    }
}

class TransactionDetailsPresenterTests: XCTestCase {
    let displaySpy = TransactionDetailsDisplaySpy()
    
    lazy var sut: TransactionDetailsPresenter = {
        let presenter = TransactionDetailsPresenter()
        presenter.viewController = displaySpy
        return presenter
    }()
    
    func testPresentTransaction_ShouldDisplayOnViewController() {
        let transaction = TransactionModel(value: 80, userName: "name", userEmail: "mail", paymentStatus: .waiting, paymentType: .creditCard, transactionDate: Date(), tax: 2.5, id: "abcdEFGH1234")
        sut.presentTransaction(transaction)
        
        XCTAssertEqual(displaySpy.displayTransactionCallCount, 1)
        XCTAssertEqual(displaySpy.displayedTransaction, transaction)
    }
}
