//
//  LoginViewControllerTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 20/04/21.
//

import XCTest
@testable import cora

class LoginViewControllerTests: XCTestCase {

    var loginViewController: LoginViewController!
    let viewModel = LoginViewModelProtocolMock()
    let coordinator = LoginViewControllerDelegateMock()

    override func setUp() {
        super.setUp()

        loginViewController = LoginViewController()
                
        loginViewController.mainStack = .init()
        loginViewController.emailTextInput = .init()
        loginViewController.passwordTextInput = .init()
        loginViewController.errorLabel = .init()
        loginViewController.button = .init()
        loginViewController.loading = .init()
        
        loginViewController.userNameLabel = .init()
        loginViewController.ordersLabel = .init()
        loginViewController.ordersAmountLabel = .init()

        loginViewController.delegate = coordinator
        loginViewController.viewModel = viewModel

        loginViewController.viewDidLoad()
        loginViewController.viewWillAppear(false)
    }
    
    func testWhenLoginButtonIsTappedShouldLoadViewModel() {
        let email = "john@due.com"
        let password = "123456"
        loginViewController.emailTextInput.text = email
        loginViewController.passwordTextInput.text = password
        loginViewController.button.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(viewModel.email, email)
        XCTAssertEqual(viewModel.password, password)
    }

    func testWhenLoginEmailEmpty() throws {
        viewModel.onUpdated?(.emailEmpty)
        XCTAssertEqual(loginViewController.errorLabel.text, "Email is required")
    }

    func testWhenLoginPasswordEmpty() throws {
        viewModel.onUpdated?(.passwordEmpty)
        XCTAssertEqual(loginViewController.errorLabel.text, "Password is required")
    }

    func testWhenLoginPasswordAndEmailEmpty() throws {
        viewModel.onUpdated?(.emailAndPasswordEmpty)
        XCTAssertEqual(loginViewController.errorLabel.text, "Email and password are required")
    }

    func testWhenLoginAuthenticating() throws {
        viewModel.onUpdated?(.authenticating)

        XCTAssertEqual(loginViewController.loading.isAnimating, true)
    }

    func testWhenLoginAuthenticated() throws {
        viewModel.onUpdated?(.authenticated)
        XCTAssertEqual(loginViewController.loading.isAnimating, false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.coordinator.verify(.authenticated())
            XCTAssertEqual(self.loginViewController.mainStack.layer.opacity, 0)
        }
    }
    
    func testWhenUserIsLoggedShouldHaveHeaderVisible() {
        viewModel.onUpdated?(.authenticated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            XCTAssert(self.loginViewController.userNameLabel.text != nil)
            XCTAssert(self.loginViewController.ordersLabel.text != nil)
            XCTAssert(self.loginViewController.ordersAmountLabel.text != nil)
        }
    }

    func testWhenLoginHasInvalidEmail() throws {
        viewModel.onUpdated?(.invalidEmail)
        XCTAssertEqual(loginViewController.errorLabel.text, "Invalid email or password")
        XCTAssertEqual(loginViewController.loading.isAnimating, false)
    }
    
    func testWhenWrongEmailAndPassword() throws {
        viewModel.onUpdated?(.wrongEmailAndPassword)
        XCTAssertEqual(loginViewController.errorLabel.text, "Invalid email or password")
        XCTAssertEqual(loginViewController.loading.isAnimating, false)
    }
}
