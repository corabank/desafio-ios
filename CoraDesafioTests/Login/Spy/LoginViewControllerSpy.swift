//
//  LoginViewControllerSpy.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
@testable import CoraDesafio

final class LoginViewControllerSpy: LoginDisplaying {
    
    var setEnableButtonValue = false
    var setEnableButtonCalled = 0
    func setEnableButton(_ isEnable: Bool) {
        setEnableButtonValue = isEnable
        setEnableButtonCalled = 1
    }
}
