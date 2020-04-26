//
//  LoginViewControllerTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 22/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class LoginViewControllerTests: XCTestCase {
    
    private var controller: LoginViewControllerMock!
    
    static var presenter: LoginPresenter? = LoginPresenter()
    
    private let timeout = 10.0
    static var loginSuccessPromise: XCTestExpectation?
    static var loginFailurePromise: XCTestExpectation?
    
    override func setUp() {
        controller = LoginViewControllerMock()
        LoginViewControllerTests.presenter?.setView(controller)
    }
    
    override func tearDown() {
        controller = nil
        LoginViewControllerTests.presenter = nil
    }
    
    func testSuccessfulLogin() {
//        LoginViewControllerTests.loginSuccessPromise = expectation(description: "Should be able to login with the right credentials")
//        controller.codeView?.authView.loginTextField.text = "Roger"
//        controller.codeView?.authView.passwordTextField.text = "cora"
//        controller.codeView?.actionButton.onTouch?()
//        self.wait(for: [LoginViewControllerTests.loginSuccessPromise!], timeout: timeout)
    }
    
    func testErrorHandling() {
//        LoginViewControllerTests.loginFailurePromise = expectation(description: "Should notify when a login fails.")
//        controller.codeView?.authView.loginTextField.text = "Teste"
//        controller.codeView?.authView.passwordTextField.text = "Erro"
//        controller.codeView?.actionButton.onTouch?()
//        self.wait(for: [LoginViewControllerTests.loginFailurePromise!], timeout: timeout)
    }
}

class LoginViewControllerMock: LoginViewController {
    
    /*
     func showLoading(_ visible: Bool) {
         super.showLoading(visible)
         if self.codeView?.authView.errorText?.isEmpty ?? false {
             LoginViewControllerTests.loginSuccessPromise?.fulfill()
         } else {
             LoginViewControllerTests.loginFailurePromise?.fulfill()
         }
     }
     */
    
    override func getAbstractInteractor() -> DKAbstractInteractor? {
        return self
    }
}

extension LoginViewControllerMock: LoginInteractorProtocol {
    func loginUser(userName: String, password: String) {
        if userName == "Roger" && password == "cora" {
            let mockUser = UserEntity(userName: "Roger", password: nil, accessToken: "abcd")
            LoginViewControllerTests.presenter?.processLogin(mockUser)
        } else {
            LoginViewControllerTests.presenter?.processLoginError()
        }
    }
    
    func setPresenter(_ abstractPresenter: DKAbstractPresenter) {}
}
