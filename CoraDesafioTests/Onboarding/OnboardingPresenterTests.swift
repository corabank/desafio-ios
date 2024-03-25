//
//  OnboardingPresenterTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio

final class OnboardingPresenterTests: XCTestCase {
    
    private var presenter: OnboardingPreseting!
    private var coordinatorSpy: OnboardingCoordinatorSpy!
    
    override func setUpWithError() throws {
        self.coordinatorSpy = OnboardingCoordinatorSpy()
        self.presenter = OnboardingPresenter(coordinator: coordinatorSpy)
    }
    
    func test_Show_Login() {
        presenter.presentLoginView()
        XCTAssertEqual(1, coordinatorSpy.performCalled)
        XCTAssertEqual(OnboardingCoordinatorFlow.login, coordinatorSpy.performCalledValue)
    }
    
    func test_Show_Regiser() {
        presenter.presentRegisterView()
        XCTAssertEqual(1, coordinatorSpy.performCalled)
        XCTAssertEqual(OnboardingCoordinatorFlow.register, coordinatorSpy.performCalledValue)
    }
}
