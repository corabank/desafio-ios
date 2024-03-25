//
//  OnboadingViewControllerTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import SnapshotTesting
import XCTest
import DesignKit
@testable import CoraDesafio

final class OnboadingViewControllerTests: XCTestCase {
    
    private var onboardingSpy: OnboardingInteractorSpy!
    
    override func setUpWithError() throws {
        self.onboardingSpy = OnboardingInteractorSpy()
    }
    
    func test_Onboarding_View() {
        let controller = OnboadingViewController(interactor: onboardingSpy)
        assertSnapshot(of: controller, as: .image)
    }
    
    func test_Onboarding_View_Open_Login() {
        let controller = OnboadingViewController(interactor: onboardingSpy)
        controller.didTapLogin(CoraButtonView.instantiate(viewModel: Mock.coraButton, action: { _ in}))
        XCTAssertEqual(1, onboardingSpy.showLoginViewCalled)
        XCTAssertEqual(1, onboardingSpy.presenterSpy.presentLoginViewCalled)
    }
    
    func test_Onboarding_View_Open_Register() {
        let controller = OnboadingViewController(interactor: onboardingSpy)
        controller.didTapRegister(CoraButtonView.instantiate(viewModel: Mock.coraButton, action: { _ in}))
        XCTAssertEqual(1, onboardingSpy.showRegisterViewCalled)
        XCTAssertEqual(1, onboardingSpy.presenterSpy.presentRegisterViewCalled)
    }
}

extension OnboadingViewControllerTests {
    enum Mock {
        static let coraButton = CoraButtonViewModel(title: CoraAccessibleText(text: "", textColor: .white, backgroundColor: .white), icon: nil, font: nil, size: .small)
    }
}
