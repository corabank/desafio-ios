//
//  ExtractLoadDetailsUseCaseTests.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import XCTest
@testable import Network
@testable import Core
@testable import Extract

final class ExtractLoadDetailsUseCaseTests: XCTestCase {

    var repository: ExtractRepositoryProtocol!
    var sut: LoadExtractDetailsUseCase!
        
    var mockResponse: ExtractDetails!
    var mockData: Data!

    override func setUp() {
        mockResponse = ExtractDetails(id: "12345", description: "mock", label: "mock", counterPartyName: "mock", dateEvent: "mock", amount: 0, status: .completed, recipient: nil, sender: nil)
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
        sut =  DefaultLoadExtractDetailsUseCase(repository: repository)
        
        let expectation = XCTestExpectation(description: "fetch details success")
    
        sut.run(withId: mockResponse.id) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.id, self.mockResponse.id)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func testFetchError() throws {
        repository = FailureMockExtractRepository()
        sut =  DefaultLoadExtractDetailsUseCase(repository: repository)

        let expectation = XCTestExpectation(description: "fetch data error")
        
        sut.run(withId: mockResponse.id) { result in
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
