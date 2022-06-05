//
//  LoginPresenterTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class LoginPresenterTests: XCTestCase {
    
    let coodinatorSpy = LoginCoordinatorSpy()
    let viewControllerSpy = LoginViewControllerSpy()
    lazy var sut = LoginPresenter(coordinator: coodinatorSpy)

    override func setUp() {
        super.setUp()
        sut.viewController = viewControllerSpy
    }
    
    func test_presentValidation() {
        sut.presentValidation(isValid: false)
        XCTAssertTrue(viewControllerSpy.enableButtonCalled)
        XCTAssertFalse(viewControllerSpy.enabledButtonIsValid)
        
        sut.presentValidation(isValid: true)
        XCTAssertTrue(viewControllerSpy.enableButtonCalled)
        XCTAssertTrue(viewControllerSpy.enabledButtonIsValid)
    }
}
