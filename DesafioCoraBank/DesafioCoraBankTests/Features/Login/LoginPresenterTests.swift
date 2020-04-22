//
//  LoginPresenterTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 22/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class LoginPresenterTests: XCTestCase {
    
    private var presenter: LoginPresenter!
    
    private let timeout = 10.0
    private var loginSuccessPromise: XCTestExpectation?
    private var loginFailurePromise: XCTestExpectation?
    
    override func setUp() {
        presenter = LoginPresenter()
        presenter.setView(self)
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testSuccessfulLogin() {
        loginSuccessPromise = expectation(description: "Should be able to notify the view when login succeeds")
        let mockUser = UserEntity(userName: "Roger", password: nil, accessToken: "abcd")
        self.presenter.processLogin(mockUser)
        self.wait(for: [self.loginSuccessPromise!], timeout: timeout)
    }
    
    func testLoginError() {
        loginFailurePromise = expectation(description: "Should be able to notify the view when login fails")
        self.presenter.processLoginError()
        self.wait(for: [self.loginFailurePromise!], timeout: timeout)
    }
}

extension LoginPresenterTests: LoginViewControllerProtocol {
    
    func completeLogin(_ user: UserEntity) {
        XCTAssertEqual(user.userName, "Roger", "Data inconsistency.")
        XCTAssertNil(user.password, "Password should not be exposed.")
        XCTAssertNotNil(user.accessToken, "This user should have an access token.")
        loginSuccessPromise?.fulfill()
    }
    
    func loginFailed() {
        loginFailurePromise?.fulfill()
    }
    
    func setInteractor(_ abstractInteractor: DKAbstractInteractor) {}
}
