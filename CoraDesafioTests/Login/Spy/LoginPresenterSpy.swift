//
//  LoginPresenterSpy.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
@testable import CoraDesafio

final class LoginPresenterSpy: LoginPresenting {
    
    var viewController: LoginDisplaying?
    
    var didPopCalled = 0
    func didPop() {
        didPopCalled = 1
    }
    
    var showPasswordViewCalled = 0
    func showPasswordView() {
        showPasswordViewCalled = 1
    }
    
    var setEnableButtonValue = false
    var setEnableButtonCalled = 0
    func setEnableButton(_ isEnable: Bool) {
        setEnableButtonValue = isEnable
        setEnableButtonCalled = 1
    }
}
