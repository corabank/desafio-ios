//
//  LoginViewTests.swift
//  CoraChallengeUITests
//
//  Created by Fellipe Ricciardi Chiarello on 4/28/22.
//

import XCTest
import SnapshotTesting
@testable import CoraChallenge

class LoginViewTests: XCTestCase {
    func testCPFView() {
        let view = UserLoginView()
        
        view.regularLabelText = "Bem-vindo de volta!"
        view.boldLabelText = "Qual seu CPF?"
        view.isLinkButtonHidden = true
        view.isPassword = false
        
        let result = verifySnapshot(matching: view, as: .image)
        
        XCTAssertNil(result)
    }
    
    func testPasswordView() {
        let view = UserLoginView()
        
        view.regularLabelText = nil
        view.boldLabelText = "Digite sua senha de acesso"
        view.isLinkButtonHidden = false
        view.isPassword = true
        
        let result = verifySnapshot(matching: view, as: .image)
        
        XCTAssertNil(result)
    }
    
}
