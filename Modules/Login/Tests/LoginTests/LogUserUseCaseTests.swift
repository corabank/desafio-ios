//
//  LogUserUseCaseTests.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 15/03/24.
//

import XCTest
@testable import Core
@testable import Login
@testable import Network

final class LogUserUseCaseTests: XCTestCase {
    // this should be in a mocked repository
    // will come back if have time
    var urlSession: URLSession!
    var service: NetworkServiceProtocol!
    var repository: LoginRepositoryProtocol!
    
    var sut: LogUserUseCase!
    
    var sendData: LoginData!
    var route: Router!
    
    var mockResponse: TokenRevalidationResponse!
    var mockData: Data!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        service = DefaultNetworkService(urlSession: urlSession)

        mockResponse = TokenRevalidationResponse(token: "token-mock")
        mockData = try! JSONEncoder().encode(mockResponse)
        
        sendData = .init(cpf: "000.000.000-00", password: "12345")
        route = AuthRoute.loginUser(data: sendData)
        
        repository = DefaultLoginRepository(networkService: service)
        
        sut = DefaultLogUserUseCase(repository: repository)
        
        super.setUp()
    }
    
    override func tearDown() {
        urlSession = nil
        service = nil
        mockResponse = nil
        mockData = nil
        repository = nil
        sendData = nil
        route = nil
        sut = nil
        
        super.tearDown()
    }

    func testLoginSuccess() throws {
       let response = HTTPURLResponse(
        url: try! route.asURLRequest().url!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: route.headers
       )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockData)
        }
        
        let expectation = XCTestExpectation(description: "login success")
        
        sut.run(requestData: sendData) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.token, self.mockResponse.token)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func testLoginError() throws {
       let response = HTTPURLResponse(
        url: try! route.asURLRequest().url!,
        statusCode: 401,
        httpVersion: nil,
        headerFields: route.headers
       )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockData)
        }
        
        let expectation = XCTestExpectation(description: "login failure")

        sut.run(requestData: sendData) { result in
            switch result {
            case .success(_):
                XCTFail("Should not be success")
            case .failure(let failure):
                XCTAssertEqual(NetworkError.requestFailed(statusCode: 401).localizedDescription, failure.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }


}
