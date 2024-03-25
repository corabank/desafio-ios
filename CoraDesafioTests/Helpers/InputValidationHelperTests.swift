//
//  InputValidationHelperTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
import CoreKit
@testable import CoraDesafio

final class InputValidationHelperTests: XCTestCase {

    private let shared = InputValidationHelper.shared
    
    
    func test_Validate_Correct_CPF() {
        let cpf = shared.validateCPF("440.437.628-60")
        XCTAssert(cpf)
    }
    
    func test_Validate_Wrong_CFP() {
        let invalid = shared.validateCPF("440213123423")
        let empty = shared.validateCPF("")
        XCTAssertFalse(invalid)
        XCTAssertFalse(empty)
    }
    
    func test_Validate_Correct_Password() {
        let password = shared.validatePassword("12345678")
        XCTAssert(password)
    }
    
    func test_Validate_Wrong_Password() {
        let invalid = shared.validateCPF("123")
        let empty = shared.validatePassword("")
        XCTAssertFalse(invalid)
        XCTAssertFalse(empty)
    }
}
