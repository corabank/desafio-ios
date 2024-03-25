//
//  LoginPresenterTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio

final class LoginPresenterTests: XCTestCase {
    
    private var presenter: LoginPresenting!
    private var coordinatorSpy: OnboardingCoordinatorSpy!
    private var viewSpy: LoginViewControllerSpy!
    
    override func setUpWithError() throws {
        self.coordinatorSpy = OnboardingCoordinatorSpy()
        self.viewSpy = LoginViewControllerSpy()
        
        self.presenter = LoginPresenter(coordinator: coordinatorSpy)
        self.presenter.viewController = viewSpy
    }
    
    func test_SetEnable_Button_True() {
        presenter.setEnableButton(true)
        XCTAssertEqual(1, viewSpy.setEnableButtonCalled)
        XCTAssert(viewSpy.setEnableButtonValue)
    }
  
    func test_SetEnable_Button_False() {
        presenter.setEnableButton(false)
        XCTAssertEqual(1, viewSpy.setEnableButtonCalled)
        XCTAssertFalse(viewSpy.setEnableButtonValue)
    }
    
    func test_Did_Pop() {
        presenter.didPop()
        XCTAssertEqual(1, coordinatorSpy.popCalled)
    }
    
    func test_Show_Password() {
        let type = OnboardingCoordinatorFlow.password
        presenter.showPasswordView()
        XCTAssertEqual(1, coordinatorSpy.performCalled)
        XCTAssertEqual(OnboardingCoordinatorFlow.password, coordinatorSpy.performCalledValue)
    }
}
