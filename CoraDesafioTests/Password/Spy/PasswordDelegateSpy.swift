//
//  PasswordDelegateSpy.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
import DesignKit
@testable import CoraDesafio

final class PasswordDelegateSpy: PasswordViewDelegate {
    
    var didTapForgotPasswordCalled = 0
    func didTapForgotPassword(_ sender: CoraButtonView) {
        didTapForgotPasswordCalled = 1
    }
    
    var didTapLogginButtonValue: String?
    var didTapLogginButtonCalled = 0
    func didTapLogginButton(_ sender: CoraButtonView, correctValue: String) {
        didTapLogginButtonCalled = 1
        didTapLogginButtonValue = correctValue
    }
    
    var didUpdatePasswordTextValue: String?
    var didUpdatePasswordTextCalled = 0
    func didUpdatePasswordText(_ value: String) {
        didUpdatePasswordTextCalled = 1
        didUpdatePasswordTextValue = value
    }
}
