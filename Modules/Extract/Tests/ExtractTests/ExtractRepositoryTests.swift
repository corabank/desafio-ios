//
//  ExtractRepositoryTests.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import XCTest
@testable import Network
@testable import Core
@testable import Extract

final class ExtractRepositoryTests: XCTestCase {
    var urlSession: URLSession!
    var service: NetworkServiceProtocol!
    var sut: ExtractRepositoryProtocol!
    
    var route: Router!
    
    var mockResponse: ExtractList!
    var mockData: Data!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        service = DefaultNetworkService(urlSession: urlSession)

        mockResponse = ExtractList(results: [], itemsTotal: 0)
        mockData = try! JSONEncoder().encode(mockResponse)
        
        route = ExtractListRoute.fetchData
        sut = DefaultExtractRepository(networkService: service)
        
        super.setUp()
    }

    override func tearDown() {
        urlSession = nil
        service = nil
        mockResponse = nil
        mockData = nil
        sut = nil
        route = nil
        
        super.tearDown()
    }

    func testFetchSuccess() throws {
        let response = HTTPURLResponse(
         url: try! route.asURLRequest().url!,
         statusCode: 200,
         httpVersion: nil,
         headerFields: route.headers
        )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockData)
        }
        
        let expectation = XCTestExpectation(description: "fetch data success")
    
        sut.executeLoad { result in
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
        let response = HTTPURLResponse(
         url: try! route.asURLRequest().url!,
         statusCode: 402,
         httpVersion: nil,
         headerFields: route.headers
        )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockData)
        }
        
        let expectation = XCTestExpectation(description: "fetch data error")
        
        sut.executeLoad { result in
            switch result {
            case .success(_):
                XCTFail("It should not be success")
            case .failure(let failure):
                XCTAssertEqual(NetworkError.requestFailed(statusCode: 402).localizedDescription, failure.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

}
