//
//  TransactionDetailsInteractorTests.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/27/22.
//

import XCTest
@testable import DesafioCora

class TransactionDetailsPresenterSpy: TransactionDetailsPresenting {
    private(set) var presentTransactionCallCount = 0
    private(set) var presentedTransaction: TransactionModel?
    
    func presentTransaction(_ transaction: TransactionModel) {
        presentTransactionCallCount += 1
        presentedTransaction = transaction
    }
}

class TransactionDetailsInteractorTests: XCTestCase {
    let model = TransactionModel(value: 100, userName: "name", userEmail: "mail", paymentStatus: .paid, paymentType: .creditCard, transactionDate: Date(), tax: 10, id: "abcdEFGH1234")
    let presenterSpy = TransactionDetailsPresenterSpy()
    
    lazy var sut: TransactionDetailsInteractor = {
        let interactor = TransactionDetailsInteractor(transaction: model, presenter: presenterSpy)
        return interactor
    }()
    
    func testLoadTransaction_ShouldPresentTransaction() {
        sut.loadTransaction()
        
        XCTAssertEqual(presenterSpy.presentTransactionCallCount, 1)
        XCTAssertEqual(presenterSpy.presentedTransaction, model)
    }
}
