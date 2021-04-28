//
//  LoginViewModelTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 20/04/21.
//

import XCTest
import SwiftyMocky
@testable import cora

class LoginViewModelTests: XCTestCase {

    let useCase = LoginUseCaseProtocolMock()
    var loginViewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        loginViewModel = LoginViewModel(useCase: useCase)
        loginViewModel.email = "lorem@ip.sum"
        loginViewModel.password = "12345"

        useCase.given(.presenter(getter: loginViewModel))
    }

    func testEmailAndPasswordEmpty() {
        loginViewModel.email = ""
        loginViewModel.password = ""
        loginViewModel.login()
        XCTAssertEqual(loginViewModel.state, LoginViewModelState.emailAndPasswordEmpty)
    }

    func testEmailAndPasswordFilled() {
        loginViewModel.email = ""
        loginViewModel.password = "lorem"
        loginViewModel.login()
        XCTAssertEqual(loginViewModel.state, LoginViewModelState.emailEmpty)
    }

    func testEmailWasFilledAndPasswordNot() {
        loginViewModel.email = "lorem@ip.sum"
        loginViewModel.password = ""
        loginViewModel.login()
        XCTAssertEqual(loginViewModel.state, LoginViewModelState.passwordEmpty)
    }

    func testLoginWhenUseCaseReturnInvalidEmail() throws {
        useCase.perform(.execute(email: .any, password: .any, perform: { (email, password) in
            self.useCase.presenter?.loginError(error: .invalidEmail)
        }))

        loginViewModel.login()
        XCTAssertEqual(loginViewModel.state, LoginViewModelState.invalidEmail)
    }


    func testLoginWhenUseCaseReturnAuthenticating() throws {
        useCase.perform(.execute(email: .any, password: .any, perform: { (email, password) in
            self.useCase.presenter?.authenticating()
        }))

        loginViewModel.login()
        XCTAssertEqual(loginViewModel.state, LoginViewModelState.authenticating)
    }

    func testLoginWhenUseCaseReturnAuthenticated() throws {
        let user = User(name: "John", email: "john@due.com")
        useCase.perform(.execute(email: .any, password: .any, perform: { (email, password) in
            self.useCase.presenter?.loginSuccess(user: user)
        }))

        loginViewModel.login()
        XCTAssertEqual(loginViewModel.state, LoginViewModelState.authenticated)
        XCTAssertEqual(State.shared.user?.id, user.id)
        XCTAssertEqual(State.shared.user?.orders.count, 0)
    }

    func testLoginWhenUseCaseReturnAPIFailure() throws {
        useCase.perform(.execute(email: .any, password: .any, perform: { (email, password) in
            self.useCase.presenter?.loginError(error: .wrongEmailOrPassword)
        }))

        loginViewModel.login()
        XCTAssertEqual(loginViewModel.state, LoginViewModelState.wrongEmailAndPassword)
    }
}

