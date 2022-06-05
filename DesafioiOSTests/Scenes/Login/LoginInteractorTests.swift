//
//  LoginInteractorTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class LoginCPFInteractorTests: XCTestCase {
    
    let presenterSpy = LoginPresenterSpy()
    lazy var sut = LoginInteractor(screenType: .cpf, presenter: presenterSpy)
    
    func test_validate() {
        sut.validate(value: "421.222.00")
        XCTAssertFalse(presenterSpy.presentValidationIsValid)
        
        sut.validate(value: "461.926.878-03")
        XCTAssertTrue(presenterSpy.presentValidationIsValid)
    }
    
    func test_nextStep() {
        sut.nextStep()
        XCTAssertTrue(presenterSpy.presentPassordViewCalled)
    }
}

final class LoginPasswordInteractorTests: XCTestCase {
    
    let presenterSpy = LoginPresenterSpy()
    lazy var sut = LoginInteractor(screenType: .password, presenter: presenterSpy)
    
    func test_validate() {
        sut.validate(value: "")
        XCTAssertFalse(presenterSpy.presentValidationIsValid)
        
        sut.validate(value: "Password")
        XCTAssertTrue(presenterSpy.presentValidationIsValid)
    }
    
    func test_nextStep() {
        sut.nextStep()
        XCTAssertTrue(presenterSpy.presentExtractCalled)
    }
}
