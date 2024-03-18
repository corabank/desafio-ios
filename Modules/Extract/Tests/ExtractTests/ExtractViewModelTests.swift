//
//  ExtractViewModelTests.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import XCTest
@testable import Network
@testable import Core
@testable import Extract

//MARK: - mocks

struct SuccessMockExtractUseCase: LoadExtractsUseCase {
    func run(completionHandler: @escaping (Result<ExtractList, NetworkError>) -> Void) {
        completionHandler(.success(.init(results: [], itemsTotal: 0)))
    }
}

struct FailureMockExtractUseCase: LoadExtractsUseCase {
    func run(completionHandler: @escaping (Result<ExtractList, NetworkError>) -> Void) {
        completionHandler(.failure(.requestFailed(statusCode: 401)))
    }
}

//MARK: - testing

final class ExtractViewModelTests: XCTestCase {
    func testSuccessFetchData() throws {
        let useCase = SuccessMockExtractUseCase()
        let sut = DefaultExtractViewModel(fetchDataUseCase: useCase)
        
        let expectation = XCTestExpectation(description: "fetch data success")
        
        sut.onFetchError = { error in
            XCTAssertThrowsError(error)
        }
        
        sut.onFetchSuccess = { data in
            XCTAssertEqual(data.itemsTotal, 0)
            expectation.fulfill()
        }
        
        sut.fetchData()
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFailureFetchData() throws {
        let useCase = FailureMockExtractUseCase()
        let sut = DefaultExtractViewModel(fetchDataUseCase: useCase)
        
        let expectation = XCTestExpectation(description: "fetch data error")
        
        sut.onFetchError = { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.requestFailed(statusCode: 401).localizedDescription)
            expectation.fulfill()
        }
        
        sut.onFetchSuccess = { _ in
            XCTFail("It should not be a success")
        }
        
        sut.fetchData()
        
        wait(for: [expectation], timeout: 5)
    }
}
