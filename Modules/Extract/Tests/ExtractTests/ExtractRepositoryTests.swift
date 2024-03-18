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
    var detailsRoute: Router!
    
    var mockListResponse: ExtractList!
    var mockDetailsResponse: ExtractDetails!
    
    var mockListData: Data!
    var mockDetailsData: Data!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        service = DefaultNetworkService(urlSession: urlSession)

        mockListResponse = ExtractList(results: [], itemsTotal: 0)
        mockListData = try! JSONEncoder().encode(mockListResponse)
        
        mockDetailsResponse = ExtractDetails(id: "12345", description: "mock", label: "mock", counterPartyName: "mock", dateEvent: "mock", amount: 0, status: .completed, recipient: nil, sender: nil)
        mockDetailsData = try! JSONEncoder().encode(mockDetailsResponse)
        
        route = ExtractRoute.fetchData
        detailsRoute = ExtractRoute.loadDetails(id: "12345")
        sut = DefaultExtractRepository(networkService: service)
        
        super.setUp()
    }

    override func tearDown() {
        urlSession = nil
        service = nil
        mockListResponse = nil
        mockListData = nil
        sut = nil
        route = nil
        mockDetailsData = nil
        mockDetailsResponse = nil
        detailsRoute = nil
        
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
            return (response, self.mockListData)
        }
        
        let expectation = XCTestExpectation(description: "fetch list success")
    
        sut.executeLoad { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.itemsTotal, self.mockListResponse.itemsTotal)
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
            return (response, self.mockListData)
        }
        
        let expectation = XCTestExpectation(description: "fetch list error")
        
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
    
    func testFetchDetailsSuccess() throws {
        let response = HTTPURLResponse(
         url: try! detailsRoute.asURLRequest().url!,
         statusCode: 200,
         httpVersion: nil,
         headerFields: detailsRoute.headers
        )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockDetailsData)
        }
        
        let expectation = XCTestExpectation(description: "fetch details success")
    
        sut.executeLoad(forId: mockDetailsResponse.id) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.id, self.mockDetailsResponse.id)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func testFetchDetailsError() throws {
        let response = HTTPURLResponse(
         url: try! detailsRoute.asURLRequest().url!,
         statusCode: 402,
         httpVersion: nil,
         headerFields: detailsRoute.headers
        )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockDetailsData)
        }
        
        let expectation = XCTestExpectation(description: "fetch data error")
        
        sut.executeLoad(forId: mockDetailsResponse.id) { result in
            switch result {
            case .success(_):
                XCTFail("It should not be success)")
            case .failure(let failure):
                XCTAssertEqual(NetworkError.requestFailed(statusCode: 402).localizedDescription, failure.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

}
