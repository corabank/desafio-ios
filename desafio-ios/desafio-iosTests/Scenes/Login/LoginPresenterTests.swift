//
//  LoginPresenterTests.swift
//  desafio-iosTests
//
//  Created by Barbara Barone on 14/02/22.
//

import XCTest
@testable import desafio_ios

private final class LoginCoordinatorSpy: LoginCoordinating {
    var viewController: UIViewController?
    
    private(set) var performCallsCount = 0
    
    private(set) var performReceivedInvocations: LoginAction?
    
    func perform(action: LoginAction) {
        performReceivedInvocations = action
        performCallsCount += 1
    }
}

private final class LoginViewControllerSpy: LoginDisplaying {
    private(set) var loginValidationCallsCount = 0
    private(set) var startLoadingCallsCount = 0
    private(set) var stopLoadingCallsCount = 0
    
    func loginValidation() {
        loginValidationCallsCount += 1
    }
    
    func startLoading() {
        startLoadingCallsCount += 1
    }
    
    func stopLoading() {
        stopLoadingCallsCount += 1
    }
}


final class LoginPresenterTests: XCTestCase {
    private let coordinatorSpy = LoginCoordinatorSpy()
    private let viewControllerSpy = LoginViewControllerSpy()
    
    private lazy var sut: LoginPresenting = {
        let presenter = LoginPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    
    func testDidNextStep_WhenNeedScreenAction_ShouldPerfomAction() {
        sut.didNextStep(action: .openHomeScreen)
        
        XCTAssertEqual(coordinatorSpy.performReceivedInvocations, .openHomeScreen)
        XCTAssertEqual(coordinatorSpy.performCallsCount, 1)
    }
    
    func testPresentError_ShouldPresentErrorLabel() {
        sut.presentError()
        
        XCTAssertEqual(viewControllerSpy.loginValidationCallsCount, 1)
    }
    
    func testPresentLoading_WhenTheDataIsRequesting_ShouldPresentLoading() {
        sut.presentLoading(shouldPresent: true)
        
        XCTAssertEqual(viewControllerSpy.startLoadingCallsCount, 1)
    }
    
    func testPresentLoading_WhenTheDataIsRequested_ShouldPresentLoading() {
        sut.presentLoading(shouldPresent: false)
        
        XCTAssertEqual(viewControllerSpy.stopLoadingCallsCount, 1)
    }
}
