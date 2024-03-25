//
//  LoginBuilderHelperTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import CoreKit
import XCTest
@testable import CoraDesafio

final class LoginBuilderHelperTests: XCTestCase {
    private let shared = LoginBuilderHelper.shared
    
    override func setUpWithError() throws {
        self.shared.setValue()
    }
    
    func test_Save_Document_Correct() {
        shared.save(.document("440.437.628-60"))
        shared.save(.password("1234567"))
        
        XCTAssertNotNil(shared.loginRequest)
        XCTAssertEqual("440.437.628-60", shared.loginRequest?.cpf)
        XCTAssertEqual("1234567", shared.loginRequest?.password)
    }
    
    func test_Set_All_Nill() {
        XCTAssertNil(shared.loginRequest)
    }
}
