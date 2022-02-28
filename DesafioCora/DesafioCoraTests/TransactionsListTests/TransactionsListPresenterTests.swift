//
//  TransactionsListPresenterTests.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/27/22.
//

import XCTest
@testable import DesafioCora

class TransactionsListCoordinatorSpy: TransactionsListCoordinating {
    var viewController: UIViewController?
    private(set) var performedAction: TransactionsListCoordinatorAction?
    
    func perform(action: TransactionsListCoordinatorAction) {
        performedAction = action
    }
}

class TransactionsListDisplaySpy: TransactionsListDisplaying {
    private(set) var displayTransactionCallCount = 0
    private(set) var displayErrorCallCount = 0
    private(set) var errorTitle: String? = ""
    private(set) var errorMessage: String? = ""
    
    func displayTransactions() {
        displayTransactionCallCount += 1
    }
    
    func displayError(title: String?, message: String?) {
        displayErrorCallCount += 1
        errorTitle = title
        errorMessage = message
    }
}

class TransactionsListPresenterTests: XCTestCase {
    let coordinatorSpy = TransactionsListCoordinatorSpy()
    let displaySpy = TransactionsListDisplaySpy()
    
    lazy var sut: TransactionsListPresenter = {
        let presenter = TransactionsListPresenter(coordinator: coordinatorSpy)
        presenter.viewController = displaySpy
        return presenter
    }()
    
    func testPresentTransactionList_ShouldDisplayTransactionsOnViewController() {
        sut.presentTransactionsList()
        
        XCTAssertEqual(displaySpy.displayTransactionCallCount, 1)
    }
    
    func testPresenterError_ShouldDisplayErrorOnViewController() {
        sut.presentError(title: "Title", message: "Message")
        
        XCTAssertEqual(displaySpy.displayErrorCallCount, 1)
        XCTAssertEqual(displaySpy.errorTitle, "Title")
        XCTAssertEqual(displaySpy.errorMessage, "Message")
    }
    
    func testPresentDetailsForTransaction_ShouldPresentDetailsViewController() {
        let model = TransactionModel(value: 100, userName: "name", userEmail: "mail", paymentStatus: .paid, paymentType: .creditCard, transactionDate: Date(), tax: 9, id: "abcdEFGH1234")
        
        sut.presentDetailsFor(transaction: model)
        
        XCTAssertEqual(coordinatorSpy.performedAction, .detail(model))
    }
}
