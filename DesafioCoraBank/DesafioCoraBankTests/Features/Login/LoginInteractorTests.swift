//
//  LoginInteractorTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 22/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class LoginInteractorTests: XCTestCase {
    
    private var interactor: LoginInteractor!
    
    private let timeout = 10.0
    private var loginSuccessPromise: XCTestExpectation?
    private var loginFailurePromise: XCTestExpectation?
    
    override func setUp() {
        interactor = LoginInteractor(enableMocks: true)
        interactor.setPresenter(self)
    }
    
    override func tearDown() {
        interactor = nil
    }
    
    func testSuccessfulLogin() {
        loginSuccessPromise = expectation(description: "Should be able to login with the right credentials")
        self.interactor.loginUser(userName: "Roger", password: "cora")
        self.wait(for: [self.loginSuccessPromise!], timeout: timeout)
    }
    
    func testLoginError() {
        loginFailurePromise = expectation(description: "Should not be able to login with the wrong credentials")
        self.interactor.loginUser(userName: "Teste", password: "Erro")
        self.wait(for: [self.loginFailurePromise!], timeout: timeout)
    }
}

extension LoginInteractorTests: LoginPresenterProtocol {
    func processLogin(_ user: UserEntity) {
        XCTAssertEqual(user.userName, "Roger", "Data inconsistency.")
        XCTAssertNil(user.password, "Password should not be exposed.")
        XCTAssertNotNil(user.accessToken, "This user should have an access token.")
        loginSuccessPromise?.fulfill()
    }
    
    func processLoginError() {
        loginFailurePromise?.fulfill()
    }
    
    func setView(_ abstractView: DKAbstractView) {}
}
