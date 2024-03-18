//
//  ExtractFetchDataUseCaseTests.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import XCTest

@testable import Network
@testable import Core
@testable import Extract

//MARK: - tests

struct SuccessMockExtractRepository: ExtractRepositoryProtocol {
    func executeLoad(forId id: String, completionHandler: @escaping ((Result<Extract.ExtractDetails, Network.NetworkError>) -> Void)) {
        completionHandler(.success(ExtractDetails(id: "12345", description: "mock", label: "mock", counterPartyName: "mock", dateEvent: "mock", amount: 0, status: .completed, recipient: nil, sender: nil)))
    }
    
    func executeLoad(completionHandler: @escaping ((Result<Extract.ExtractList, Network.NetworkError>) -> Void)) {
        completionHandler(.success(.init(results: [], itemsTotal: 0)))
    }
}

struct FailureMockExtractRepository: ExtractRepositoryProtocol {
    func executeLoad(forId id: String, completionHandler: @escaping ((Result<Extract.ExtractDetails, Network.NetworkError>) -> Void)) {
        completionHandler(.failure(.requestFailed(statusCode: 401)))
    }
    
    func executeLoad(completionHandler: @escaping ((Result<Extract.ExtractList, Network.NetworkError>) -> Void)) {
        completionHandler(.failure(.requestFailed(statusCode: 401)))
    }
}

//MARK: - tests

final class ExtractFetchDataUseCaseTests: XCTestCase {
    var repository: ExtractRepositoryProtocol!
    var sut: LoadExtractsUseCase!
        
    var mockResponse: ExtractList!
    var mockData: Data!

    override func setUp() {
        mockResponse = ExtractList(results: [], itemsTotal: 0)
        mockData = try! JSONEncoder().encode(mockResponse)
        
        
        super.setUp()
    }

    override func tearDown() {
        repository = nil
        mockResponse = nil
        mockData = nil
        sut = nil
        
        super.tearDown()
    }

    func testFetchSuccess() throws {
        repository = SuccessMockExtractRepository()
        sut = DefaultLoadExtractsUseCase(repository: repository)
        
        let expectation = XCTestExpectation(description: "fetch data success")
    
        sut.run  { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.itemsTotal, self.mockResponse.itemsTotal)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func testFetchError() throws {
        repository = FailureMockExtractRepository()
        sut = DefaultLoadExtractsUseCase(repository: repository)
       
        let expectation = XCTestExpectation(description: "fetch data error")
        
        sut.run { result in
            switch result {
            case .success(_):
                XCTFail("It should not be success")
            case .failure(let failure):
                XCTAssertEqual(NetworkError.requestFailed(statusCode: 401).localizedDescription, failure.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

}
