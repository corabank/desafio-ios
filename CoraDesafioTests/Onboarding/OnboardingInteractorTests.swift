//
//  OnboardingInteractorTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio

final class OnboardingInteractorTests: XCTestCase {

    private var interactor: OnboardingInteracting!
    private var presenterSpy: OnboardingPresenterSpy!
    
    override func setUpWithError() throws {
        self.presenterSpy = OnboardingPresenterSpy()
        self.interactor = OnboardingInteractor(presenter: presenterSpy)
    }

    func test_Show_Login_View() {
        interactor.showLoginView()
        XCTAssertEqual(1, presenterSpy.presentLoginViewCalled)
    }
    
    func test_Show_Register_View() {
        interactor.showRegisterView()
        XCTAssertEqual(1, presenterSpy.presentRegisterViewCalled)
    }
}
