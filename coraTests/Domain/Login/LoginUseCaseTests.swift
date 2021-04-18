//
//  LoginUseCaseTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 16/04/21.
//

import XCTest
import SwiftyMocky
@testable import cora

class LoginUseCaseTests: XCTestCase {

    var user: User!
    var loginRepository: LoginRepositoryProtocolMock!
    var loginPresenter: LoginPresenterMock!

    var useCase: LoginUseCase!

    override func setUp() {
        super.setUp()

        self.user = User(name: "James Bond", email: "bond@007.com")
        self.loginRepository = LoginRepositoryProtocolMock()
        self.loginPresenter = LoginPresenterMock()
        self.useCase = LoginUseCase(repository: loginRepository)
        useCase.presenter = loginPresenter
    }

    fileprivate func loginRepositoryPerfomLogin() {
        loginRepository.perform(
            .login(
                email: .any,
                password: .any,
                completionHandler: .any,
                perform: { (email, password, completionHandler) in
                    completionHandler(.success(self.user))
            }
            )
        )
    }

    func test_login_should_return_a_valid_user() throws {

        loginRepositoryPerfomLogin()

        useCase.execute(email: "test@email.com", password: "123test")

        loginPresenter.verify(.authenticating())
        loginPresenter.verify(.loginSuccess(user: .any))
        loginRepository.verify(.login(email: .any, password: .any, completionHandler: .any))
    }

    func test_login_should_return_failure() {
        loginRepository.perform(
            .login(
                email: .any,
                password: .any,
                completionHandler: .any,
                perform: { (email, password, completionHandler) in
                    completionHandler(.failure(URLError(.unknown)))
                }
            )
        )

        useCase.execute(email: "wrong_test@email.com", password: "123test_wrong")

        loginPresenter.verify(.authenticating())
        loginPresenter.verify(.loginError(error: .value(.wrongEmailOrPassword)))
        loginPresenter.verify(.loginError(error: .any), count: 1)
        loginRepository.verify(.login(email: .any, password: .any, completionHandler: .any))
    }
    
    func test_login_should_return_invalid_email_failure() {
        loginRepository.perform(
            .login(
                email: .any,
                password: .any,
                completionHandler: .any,
                perform: { (email, password, completionHandler) in
                    completionHandler(.failure(URLError(.unknown)))
                }
            )
        )

        useCase.execute(email: "wrong_test@", password: "123test_wrong")

        loginPresenter.verify(.loginError(error: .value(.invalidEmail)))
        loginPresenter.verify(.loginError(error: .any), count: 1)
        loginPresenter.verify(.authenticating(), count: 0)
        loginRepository.verify(.login(email: .any, password: .any, completionHandler: .any), count: 0)
    }
}
