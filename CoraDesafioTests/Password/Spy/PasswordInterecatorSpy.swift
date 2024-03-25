//
//  PasswordInterecatorTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
@testable import CoraDesafio

final class PasswordInterectorSpy: PasswordInteracting {
    
    var didPopCalled = 0
    func didPop() {
        didPopCalled = 1
    }
    
    var validatePasswordValue = ""
    var validatePasswordCalled = 0
    func validatePassword(_ value: String) {
        validatePasswordCalled = 1
        validatePasswordValue = value
    }
    
    var savePasswordOnMemoryValue = ""
    var savePasswordOnMemoryCalled = 0
    func savePasswordOnMemory(_ value: String) {
        savePasswordOnMemoryCalled = 1
        savePasswordOnMemoryValue = value
    }
}
