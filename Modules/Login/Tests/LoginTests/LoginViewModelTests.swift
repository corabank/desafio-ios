//
//  LoginViewModelTests.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 15/03/24.
//

import XCTest
@testable import Core
@testable import Login
@testable import Network

struct MockUseCase: LogUserUseCase {
    func run(requestData: LoginData, completion: @escaping (Result<TokenRevalidationResponse, NetworkError>) -> Void) {
        if requestData.cpf.isEmpty || requestData.password
            .isEmpty {
            completion(.failure(.invalidResponse))
            return
        }
        
        completion(.success(.init(token: "12345")))
    }
}

//MARK: - ViewModel test

final class LoginViewModelTests: XCTestCase {
    var useCase: LogUserUseCase!
    var sut: LoginViewModelProtocol!
    
    
    override func setUpWithError() throws {
        useCase = MockUseCase()
        sut = DefaultLoginViewModel(loginUseCase: useCase)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        useCase = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testValidCPF() throws {
        let mockCPF = "977.656.400-38"
        let isValid = sut.isValid(cpf: mockCPF)
        XCTAssertTrue(isValid)
    }
    
    func testInvalidCPF() throws {
        let mockCPF = "97.656.400-38"
        let isValid = sut.isValid(cpf: mockCPF)
        XCTAssertFalse(isValid)
    }
    
    func testValidPass() throws {
        let mockPass = "12345"
        let isValid = sut.isValid(password: mockPass)
        XCTAssertTrue(isValid)
    }
    
    func testInvalidPass() throws {
        let mockPass = ""
        let isValid = sut.isValid(password: mockPass)
        XCTAssertFalse(isValid)
    }
    
    func testLoginSuccess() throws {
        let mockData = LoginData(cpf:  "977.656.400-38", password: "12345")
        
        let expectation = XCTestExpectation(description: "login success")
        
        sut.onLoginSuccess = { data in
            XCTAssertFalse(data.token.isEmpty)
            expectation.fulfill()
        }
        
        sut.onLoginError = { error in
            XCTAssertThrowsError(error)
        }
        
        sut.didSubmit(login: mockData)
        
        wait(for: [expectation], timeout: 5)
    }

    func testLoginError() throws {
        let mockData = LoginData(cpf:  "", password: "")
        
        let expectation = XCTestExpectation(description: "login error")
        
        sut.onLoginSuccess = { _ in
            XCTFail("Should not have completed with success")
        }
        
        sut.onLoginError = { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.invalidResponse.localizedDescription)
            expectation.fulfill()
        }
        
        sut.didSubmit(login: mockData)
        
        wait(for: [expectation], timeout: 5)
    }

}
