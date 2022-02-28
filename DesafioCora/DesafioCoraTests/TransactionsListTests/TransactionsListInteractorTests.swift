//
//  TransactionsListInteractorTests.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/27/22.
//

import XCTest
@testable import DesafioCora

class TransactionsListServiceMock: TransactionsListServicing {
    var result: Result<[TransactionModel], ServiceError> = .failure(.unknowError)
    
    func loadTransactions(completion: @escaping (Result<[TransactionModel], ServiceError>) -> Void) {
        completion(result)
    }
}

class TransactionListPresenterSpy: TransactionsListPresenting {
    private(set) var presentTransactionsListCallCount = 0
    private(set) var presentDetailsForTransactionCallCount = 0
    private(set) var selectedTransaction: TransactionModel?
    private(set) var presentErrorCallCount = 0
    private(set) var errorTitle: String? = ""
    private(set) var errorMessage: String? = ""
    
    func presentTransactionsList() {
        presentTransactionsListCallCount += 1
    }
    
    func presentDetailsFor(transaction: TransactionModel) {
        presentDetailsForTransactionCallCount += 1
        selectedTransaction = transaction
    }
    
    func presentError(title: String?, message: String?) {
        presentErrorCallCount += 1
        errorTitle = title
        errorMessage = message
    }
}

class TransactionsListInteractorTests: XCTestCase {
    let mockedService = TransactionsListServiceMock()
    let presenterSpy = TransactionListPresenterSpy()
    
    lazy var sut: TransactionsListInteractor = {
        let interactor = TransactionsListInteractor(service: mockedService, presenter: presenterSpy)
        return interactor
    }()
    
    func testLoadTransaction_WhenServiceIsSuccess_ShouldPresentTransactions() {
        mockedService.result = .success(TransactionModel.sampleData())
        sut.loadTransactions()
        
        XCTAssertEqual(presenterSpy.presentTransactionsListCallCount, 1)
    }
    
    func testSelectTransaction_WhenIndexIsInvalid_ShouldNotPresentTheTransaction() {
        sut.select(transaction: -1)
        
        XCTAssertEqual(presenterSpy.presentDetailsForTransactionCallCount, 0)
    }
    
    
    func testSelectTransaction_WhenIndexIsBiggerThanTransactionsCount_ShouldNotPresentTheTransaction() {
        mockedService.result = .success(TransactionModel.sampleData())
        sut.loadTransactions()
        
        XCTAssertEqual(sut.transactions.count, 10)
        
        sut.select(transaction: 100)
        XCTAssertEqual(presenterSpy.presentDetailsForTransactionCallCount, 0)
    }
    
    func testSelectTransaction_WhenIndexIsValid_ShouldPresenterTransactionsDetails() {
        mockedService.result = .success(TransactionModel.sampleData())
        sut.loadTransactions()
        sut.select(transaction: 0)
        
        XCTAssertEqual(presenterSpy.presentDetailsForTransactionCallCount, 1)
        XCTAssertEqual(presenterSpy.selectedTransaction?.userEmail, "cacucacau@moip.com.br")
    }
    
    func testLoadTransactions_WhenServiceReturnsRequestError_ShouldPresentError() {
        mockedService.result = .failure(.requestError(.init(code: 999, title: "Ops!", message: "Algo deu errado")))
        sut.loadTransactions()
        
        XCTAssertEqual(presenterSpy.presentErrorCallCount, 1)
        XCTAssertEqual(presenterSpy.errorTitle, "Ops!")
        XCTAssertEqual(presenterSpy.errorMessage, "Algo deu errado")
    }
    
    func testLoadTransactions_WhenServiceReturnsOtherError_ShouldPresentError() {
        mockedService.result = .failure(.unknowError)
        sut.loadTransactions()
        
        XCTAssertEqual(presenterSpy.presentErrorCallCount, 1)
        XCTAssertEqual(presenterSpy.errorTitle, "Ops!")
        XCTAssertEqual(presenterSpy.errorMessage, "Algo deu errado")
    }
}
