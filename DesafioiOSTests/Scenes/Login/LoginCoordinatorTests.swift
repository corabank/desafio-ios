//
//  LoginCoordinatorTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class LoginCoordinatorTests: XCTestCase {
    
    func test_showPassword() {
        let (sut, navigationSpy) = makeSut()
        sut.showPassword()
 
        XCTAssertTrue(navigationSpy.pushedViewController is LoginViewController)
        XCTAssertEqual(navigationSpy.pushViewControllerCallCount, 2)
    }
    
    func test_showExtract() {
        let (sut, navigationSpy) = makeSut()
        sut.showExtract()

        XCTAssertTrue(navigationSpy.pushedViewController is ExtractViewController)
        XCTAssertEqual(navigationSpy.pushViewControllerCallCount, 2)
    }
}

extension LoginCoordinatorTests {
    func makeSut() -> (LoginCoordinator, UINavigationControllerSpy) {
        let viwControllerSpy = UIViewControllerSpy()
        let navigationSpy = UINavigationControllerSpy(rootViewController: viwControllerSpy)
        let sut = LoginCoordinator()
        sut.viewController = viwControllerSpy

        return (sut, navigationSpy)
    }
}
