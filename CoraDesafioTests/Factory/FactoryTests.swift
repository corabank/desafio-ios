//
//  FactoryTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio
import NetwokKit
import SwiftUI

final class FactoryTests: XCTestCase {

    func testOnboardingFactory() {
        let viewController = OnboardingFactory.make()
        XCTAssertTrue(viewController is OnboadingViewController)

        guard let onboardingViewController = viewController as? OnboadingViewController else {
            XCTFail("Erro ao converter para OnboadingViewController")
            return
        }
        XCTAssertNotNil(onboardingViewController.interactor)
    }

    func testLoginFactory() {
        let coordinator = OnboardingCoordinator()
        let viewController = LoginFactory.make(coordinator: coordinator)
        XCTAssertTrue(viewController is LoginViewController)

        guard let loginViewController = viewController as? LoginViewController else {
            XCTFail("Erro ao converter para LoginViewController")
            return
        }
        XCTAssertNotNil(loginViewController.interactor)
    }

    func testPasswordFactory() {
        let coordinator = OnboardingCoordinator()
        let viewController = PasswordFactory.make(coordinator: coordinator)
        XCTAssertTrue(viewController is PasswordViewController)

        guard let passwordViewController = viewController as? PasswordViewController else {
            XCTFail("Erro ao converter para PasswordViewController")
            return
        }
        XCTAssertNotNil(passwordViewController.interactor)
    }

    func testExtractFactory() {
        let coordinator = OnboardingCoordinator()
        let service = CoraService()
        let viewController = ExtractFactory.make(coordinator: coordinator, service: service)
        XCTAssertTrue(viewController is UIHostingController<ExtractListView>)

        guard let hostingController = viewController as? UIHostingController<ExtractListView>,
              let extractListView = hostingController.rootView as? ExtractListView else {
            XCTFail("Erro ao converter para ExtractListView")
            return
        }
        XCTAssertNotNil(extractListView.viewModel)
        XCTAssertNotNil(extractListView.viewModel.coordinator)
    }
}
