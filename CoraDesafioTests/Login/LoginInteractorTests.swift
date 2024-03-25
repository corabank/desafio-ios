//
//  LoginInteractorTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio

final class LoginInteractorTests: XCTestCase {
    
    private var interactor: LoginInteracting!
    private var presenterSpy: LoginPresenterSpy!

    override func setUpWithError() throws {
        self.presenterSpy = LoginPresenterSpy()
        self.interactor = LoginInteractor(presenter: presenterSpy)
    }
    
    func test_Did_Pop() {
        interactor.didPop()
        XCTAssertEqual(1, presenterSpy.didPopCalled)
    }
    
    func test_Save_Password() {
        interactor.saveCpfOnMemory("440.437.628-60")
        XCTAssertEqual(1, presenterSpy.showPasswordViewCalled)
    }
    
    func test_Validate_Input_Correct() {
        interactor.validateCpfInput("440.437.628-60")
        XCTAssertEqual(1, presenterSpy.setEnableButtonCalled)
        XCTAssert(presenterSpy.setEnableButtonValue)
    }
    
    func test_Validate_Input_Incorrect() {
        interactor.validateCpfInput("123")
        XCTAssertEqual(1, presenterSpy.setEnableButtonCalled)
        XCTAssertFalse(presenterSpy.setEnableButtonValue)
    }
}
