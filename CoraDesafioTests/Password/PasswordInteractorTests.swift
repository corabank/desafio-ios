//
//  PasswordInteractorTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
import NetwokKit
@testable import CoraDesafio

final class PasswordInteractorTests: XCTestCase {

    private var interactor: PasswordInteracting!
    
    private var presenterSpy: PasswordPresenterSpy!
    private var serviceSpy: CoraServiceSpy!
    
    override func setUpWithError() throws {
        self.presenterSpy = PasswordPresenterSpy()
        self.serviceSpy = CoraServiceSpy()
        self.interactor = PasswordInteractor(presenter: presenterSpy, service: serviceSpy)
    }
    
    func test_Did_Pop() {
        interactor.didPop()
        XCTAssertEqual(1, presenterSpy.didPopCalled)
    }
    
    func test_Validate_Password_Correct() {
        interactor.validatePassword("1234567")
        XCTAssertEqual(1, presenterSpy.setEnableButtonCalled)
        XCTAssert(presenterSpy.setEnableButtonValue)
    }

    func test_Validate_Password_Invalid() {
        interactor.validatePassword("1234")
        XCTAssertEqual(1, presenterSpy.setEnableButtonCalled)
        XCTAssertFalse(presenterSpy.setEnableButtonValue)
    }
    
    func test_SavePasswor_on_Memory() {
        interactor.savePasswordOnMemory("123456")
        XCTAssertEqual(1, presenterSpy.startLoadingButtonCalled)
    }
}
