//
//  LoginPresenterTests.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/27/22.
//

import Foundation
@testable import DesafioCora
import XCTest

final class LoginCoordinatorSpy: LoginCoordinating {
    private(set) var action: LoginCoordinatorAction?
    
    func perform(action: LoginCoordinatorAction) {
        self.action = action
    }
    
    var viewController: UIViewController?
}

final class LoginDisplaySpy: LoginDisplaying {
    private(set) var displayLoadingCallCount = 0
    private(set) var isLoading = false
    private(set) var displayErrorCallCount = 0
    private(set) var errorTitle: String? = ""
    private(set) var errorMessage: String? = ""
    
    func displayLoading(_ display: Bool) {
        displayLoadingCallCount += 1
        isLoading = display
    }
    
    func displayError(title: String?, message: String?) {
        displayErrorCallCount += 1
        errorTitle = title
        errorMessage = message
    }
}

final class LoginPresenterTests: XCTestCase {
    private let coordinatorSpy = LoginCoordinatorSpy()
    private let displaySpy = LoginDisplaySpy()
    
    lazy var sut: LoginPresenter = {
        let presenter = LoginPresenter(coordinator: coordinatorSpy)
        presenter.viewController = displaySpy
        return presenter
    }()
    
    func testPresenteError_ShouldDisplayErrorOnViewController() {
        sut.presentError(title: "Ops!", message: "Error Message")
        
        XCTAssertEqual(displaySpy.displayErrorCallCount, 1)
        XCTAssertEqual(displaySpy.errorMessage, "Error Message")
        XCTAssertEqual(displaySpy.errorTitle, "Ops!")
    }
    
    func testPresentLoading_ShouldDisplayLoadingOnViewController() {
        sut.presentLoading(true)
        
        XCTAssert(displaySpy.isLoading)
        XCTAssertEqual(displaySpy.displayLoadingCallCount, 1)
        
        sut.presentLoading(false)
        
        XCTAssertFalse(displaySpy.isLoading)
        XCTAssertEqual(displaySpy.displayLoadingCallCount, 2)
    }
    
    func testPresentSuccess_ShouldCallCoordinatorLoginAction() {
        sut.presentSuccess(loginResponse: .init(token: "adsa", id: "asdas", name: "Lucas"))
        
        XCTAssertEqual(coordinatorSpy.action, .login)
    }
}
