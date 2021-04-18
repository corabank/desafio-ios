//
//  LoginRepositoryIntegrationTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 16/04/21.
//

import XCTest
@testable import cora

class LoginRepositoryIntegrationTests: XCTestCase {
    var loginDataSource: LoginDataSource!
    var loginRepository: LoginRepository!
    
    let timeout = 120.0

    override func setUp() {
        super.setUp()
        loginDataSource = LoginDataSource()
        loginRepository = LoginRepository(loginDataSource: loginDataSource)
    }
    
    func test_integration_login_repository_with_data_sources() {
        let loginExpectation = XCTestExpectation(description: "waiting login reponse")
        let email = "lucas.fernandes.silveira@gmail.com"
        let password = "caveira2021"
        
        self.loginRepository.login(email: email, password: password) { result in
            let user = try? result.get()
            XCTAssertNotNil(user)
            loginExpectation.fulfill()
        }
        
        self.wait(for: [loginExpectation], timeout: timeout)
    }
    
    func test_integration_login_repository_should_hanle_error() {
        let loginExpectation = XCTestExpectation(description: "waiting login reponse")
        let email = "georgecloney@mail.com"
        let password = "skull"
        
        self.loginRepository.login(email: email, password: password) { result in
            let user = try? result.get()
            XCTAssertNil(user)
            loginExpectation.fulfill()
        }
        
        self.wait(for: [loginExpectation], timeout: timeout)
    }
}
