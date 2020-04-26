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
    
    private var controller: LoginViewController!
    static var presenter: LoginPresenter = LoginPresenter()
    static var router: LoginRouterMock = LoginRouterMock()
    
    private let timeout = 10.0
    static var loginSuccessPromise: XCTestExpectation?
    static var loginFailurePromise: XCTestExpectation?
    
    override func setUp() {
        
    }
    
    private func setupForFetching() {
        controller = LoginViewControllerMock()
        
        controller.router = LoginViewControllerTests.router
        LoginViewControllerTests.router.viewController = controller
        
        LoginViewControllerTests.presenter.setView(controller)
        controller.loadView()
        controller.viewDidLoad()
    }
    
    override func tearDown() {
        controller = nil
    }
    
    func testSuccessfulLogin() {
        setupForFetching()
        LoginViewControllerTests.loginSuccessPromise = expectation(description: "Should be able to login with the right credentials")
        controller.codeView?.authView.loginTextField.text = "Roger"
        controller.codeView?.authView.passwordTextField.text = "cora"
        controller.codeView?.actionButton.onTouch?()
        self.wait(for: [LoginViewControllerTests.loginSuccessPromise!], timeout: timeout)
    }
    
    func testErrorHandling() {
        setupForFetching()
        LoginViewControllerTests.loginFailurePromise = expectation(description: "Should notify when a login fails.")
        controller.codeView?.authView.loginTextField.text = "Teste"
        controller.codeView?.authView.passwordTextField.text = "Erro"
        controller.codeView?.actionButton.onTouch?()
        self.wait(for: [LoginViewControllerTests.loginFailurePromise!], timeout: timeout)
    }
    
    func testLoading() {
        controller = LoginViewController()
        controller.loadView()
        controller.viewDidLoad()
        controller.codeView?.authView.loginTextField.text = "Roger"
        controller.codeView?.authView.passwordTextField.text = "cora"
        controller.authAction()
        XCTAssertFalse(controller.codeView?.loading.isHidden ?? true, "Should show loading when loggin in")
    }
    
    func testKeyboardHidden() {
        controller = LoginViewController()
        controller.loadView()
        controller.viewWillDisappear(true)
        XCTAssertFalse(controller.codeView?.authView.loginTextField.isFirstResponder ?? true, "Login textField should not be on focus.")
        XCTAssertFalse(controller.codeView?.authView.passwordTextField.isFirstResponder ?? true, "Password textField should not be on focus.")
    }
}

class LoginViewControllerMock: LoginViewController {
    override func getAbstractInteractor() -> DKAbstractInteractor? {
        return self
    }
    
    override func getAbstractRouter() -> DKAbstractRouter? {
        return LoginViewControllerTests.router
    }
    
    override func showError() {
        super.showError()
        XCTAssertFalse(codeView?.authView.errorText?.isEmpty ?? true, "Should notify the user")
        LoginViewControllerTests.loginFailurePromise?.fulfill()
    }
}

extension LoginViewControllerMock: LoginInteractorProtocol {
    func loginUser(userName: String, password: String) {
        if userName == "Roger" && password == "cora" {
            let mockUser = UserEntity(userName: "Roger", password: nil, accessToken: "abcd")
            LoginViewControllerTests.presenter.processLogin(mockUser)
        } else {
            LoginViewControllerTests.presenter.processLoginError()
        }
    }
    
    func setPresenter(_ abstractPresenter: DKAbstractPresenter) {}
}

class LoginRouterMock: LoginRouter {
    override func logIn(user: UserEntity, logoImage: UIView) {
        super.logIn(user: user, logoImage: logoImage)
        XCTAssertNotNil(user.userName, "Should have an user name.")
        XCTAssertNotNil(logoImage, "Should have a logo image to animate.")
        LoginViewControllerTests.loginSuccessPromise?.fulfill()
    }
}
