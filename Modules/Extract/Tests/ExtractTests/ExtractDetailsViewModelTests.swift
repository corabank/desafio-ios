//
//  ExtractDetailsViewModelTests.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import XCTest

@testable import Network
@testable import Core
@testable import Extract


//MARK: - mocks

struct SuccessMockExtractDetailsUseCase: LoadExtractDetailsUseCase {
    func run(withId id: String, completionHandler: @escaping (Result<ExtractDetails, NetworkError>) -> Void) {
        completionHandler(.success(ExtractDetails(id: "12345", description: "mock", label: "mock", counterPartyName: "mock", dateEvent: "mock", amount: 0, status: .completed, recipient: nil, sender: nil)))
    }
}

struct FailureMockExtractDetailsUseCase: LoadExtractDetailsUseCase {
    func run(withId id: String, completionHandler: @escaping (Result<ExtractDetails, NetworkError>) -> Void) {
        completionHandler(.failure(.requestFailed(statusCode: 401)))
    }
}

//MARK: - testing

final class ExtractDetailsViewModelTests: XCTestCase {
    func testSuccessFetchData() throws {
        let useCase = SuccessMockExtractDetailsUseCase()
        let sut = DefaultExtractDetailsViewModel(loadDetailsUseCase: useCase)
        
        let expectation = XCTestExpectation(description: "fetch data success")
        
        sut.onFetchError = { error in
            XCTAssertThrowsError(error)
        }
        
        sut.onFetchSuccess = { data in
            XCTAssertEqual(data.id, "12345")
            expectation.fulfill()
        }
        
        sut.fetchData(withId: "12345")
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFailureFetchData() throws {
        let useCase = FailureMockExtractDetailsUseCase()
        let sut = DefaultExtractDetailsViewModel(loadDetailsUseCase: useCase)
        
        let expectation = XCTestExpectation(description: "fetch data error")
        
        sut.onFetchError = { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.requestFailed(statusCode: 401).localizedDescription)
            expectation.fulfill()
        }
        
        sut.onFetchSuccess = { _ in
            XCTFail("It should not be a success")
        }
        
        sut.fetchData(withId: "12345")
        
        wait(for: [expectation], timeout: 5)
    }

}
