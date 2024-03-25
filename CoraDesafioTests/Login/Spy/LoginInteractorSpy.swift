//
//  LoginInteractorSpy.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
@testable import CoraDesafio

final class LoginInteractorSpy: LoginInteracting {
    
    var didPopCalled = 0
    func didPop() {
        didPopCalled = 1
    }
    
    var cpfValue = ""
    var saveCpfOnMemoryCalled = 0
    func saveCpfOnMemory(_ cpf: String) {
        saveCpfOnMemoryCalled = 1
        cpfValue = cpf
    }
    
    var validateCpfInputValue = ""
    var validateCpfInputCalled = 0
    func validateCpfInput(_ value: String) {
        validateCpfInputCalled = 1
        validateCpfInputValue = value
    }
}
