//
//  PasswordViewTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio
import DesignKit
class PasswordViewTests: XCTestCase {

    var passwordView: PasswordView!
    var mockDelegate: PasswordDelegateSpy!
    
    override func setUp() {
        super.setUp()
        
        passwordView = PasswordView()
        mockDelegate = PasswordDelegateSpy()
        passwordView.delegate = mockDelegate
    }

    override func tearDown() {
        passwordView = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func test_SetEnable_Button() {
        passwordView.setEnableButton(true)
        
        XCTAssertTrue(passwordView.confirmButton.isEnabled)
    }
    
    func test_SetLoading_Button() {
        passwordView.setLoadingButton()
        XCTAssertTrue(passwordView.confirmButton.isLoading)
    }
    
    func test_StopLoading_Button() {
        passwordView.stopLoadingButton()
        
        XCTAssertFalse(passwordView.confirmButton.isLoading)
    }
    
    func test_DidTap_ForgotPassword() {
        passwordView.delegate?.didTapForgotPassword(CoraButtonView.instantiate(viewModel: Mock.coraButton, action: {_ in}))
        
        XCTAssertEqual(1, mockDelegate.didTapForgotPasswordCalled)
    }
    
    func test_DidTap_Login() {
        passwordView.delegate?.didTapLogginButton(CoraButtonView.instantiate(viewModel: Mock.coraButton, action: {_ in}), correctValue: "Teste 123")
        
        XCTAssertEqual(1, mockDelegate.didTapLogginButtonCalled)
        XCTAssertEqual("Teste 123", mockDelegate.didTapLogginButtonValue)
    }
    
    func test_Did_Update_Password() {
        passwordView.textDidUpdateText(value: "123")
        passwordView.delegate?.didUpdatePasswordText("123")
        XCTAssertEqual(1, mockDelegate.didUpdatePasswordTextCalled)
        XCTAssertEqual("123", mockDelegate.didUpdatePasswordTextValue)
    }
}

extension PasswordViewTests {
    enum Mock {
        static let coraButton = CoraButtonViewModel(title: CoraAccessibleText(text: "", textColor: .white, backgroundColor: .white), icon: nil, font: nil, size: .small)
    }
}
