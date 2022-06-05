//
//  LoginPresenterSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias LoginPresenterDummy = LoginPresenterSpy

final class LoginPresenterSpy: LoginPresenting {
    var viewController: LoginDisplaying?
    
    private(set) var presentValidationCalled = false
    private(set) var presentValidationIsValid = false
    func presentValidation(isValid: Bool) {
        presentValidationCalled = true
        presentValidationIsValid = isValid
    }
    
    private(set) var presentPassordViewCalled = false
    func presentPassordView() {
        presentPassordViewCalled = true
    }
    
    private(set) var presentExtractCalled = false
    func presentExtract() {
        presentExtractCalled = true
    }
}
