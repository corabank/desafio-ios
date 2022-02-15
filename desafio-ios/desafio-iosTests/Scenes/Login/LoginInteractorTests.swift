//
//  LoginInteractorTests.swift
//  desafio-iosTests
//
//  Created by Barbara Barone on 14/02/22.
//

import XCTest
@testable import desafio_ios

private final class LoginPresenterSpy: LoginPresenting {
    var viewController: LoginDisplaying?
    
    private(set) var didNextStepCallsCount = 0
    private(set) var presentErrorCallsCount = 0
    private(set) var presentLoadingCallsCount = 0
    
    private(set) var didNextStepCallsReceivedInvocations: LoginAction?
    private(set) var presentLoadingReceivedInvocations: Bool?
    
    func didNextStep(action: LoginAction) {
        didNextStepCallsReceivedInvocations = action
        didNextStepCallsCount += 1
    }
    
    func presentError() {
        presentErrorCallsCount += 1
    }
    
    func presentLoading(shouldPresent: Bool) {
        presentLoadingReceivedInvocations = shouldPresent
        presentLoadingCallsCount += 1
    }
}

final class LoginInteractorTests: XCTestCase {
    private let presenter = LoginPresenterSpy()
    
    private lazy var sut: LoginInteracting = LoginInteractor(presenter: presenter)
    
    func testDidLogin_WhenUsernameAndPasswordIsCorrect_ShouldPresentHome() {
        let expectation = expectation(description: "Login success")
        sut.didLogin(username: "PeterParker", password: "1234")
        
        XCTAssertEqual(presenter.presentLoadingReceivedInvocations, true)
        XCTAssertEqual(presenter.presentLoadingCallsCount, 1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.presenter.didNextStepCallsReceivedInvocations, .openHomeScreen)
            XCTAssertEqual(self.presenter.didNextStepCallsCount, 1)
            XCTAssertEqual(self.presenter.presentLoadingCallsCount, 2)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDidLogin_WhenUsernameAndPasswordIsIncorrect_ShouldPresentHome() {
        sut.didLogin(username: "Peter", password: "123")
        
        XCTAssertEqual(presenter.presentErrorCallsCount, 1)
    }
}
