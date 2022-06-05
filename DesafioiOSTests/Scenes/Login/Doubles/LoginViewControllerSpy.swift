//
//  LoginViewControllerSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias LoginViewControllerDummy = LoginViewControllerSpy

final class LoginViewControllerSpy: LoginDisplaying {
    private(set) var enableButtonCalled = false
    private(set) var enabledButtonIsValid = false
    func enableButton(_ isValid: Bool) {
        enableButtonCalled = true
        enabledButtonIsValid = isValid
    }

}
