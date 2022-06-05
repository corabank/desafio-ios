//
//  IntroCoordinatorTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class IntroCoordinatorTests: XCTestCase {
    func test_showLogin_callsPushViewController() {
        let (sut, navigationSpy) = makeSut()
        
        sut.showLogin()
        
        XCTAssertTrue(navigationSpy.pushedViewController is LoginViewController)
        XCTAssertEqual(navigationSpy.pushViewControllerCallCount, 2)
    }
}

// MARK: - Helpers
extension IntroCoordinatorTests {
    func makeSut() -> (IntroCoordinator, UINavigationControllerSpy) {
        let viwControllerSpy = UIViewControllerSpy()
        let navigationSpy = UINavigationControllerSpy(rootViewController: viwControllerSpy)
        let sut = IntroCoordinator()
        sut.viewController = viwControllerSpy
        
        return (sut, navigationSpy)
    }
}


