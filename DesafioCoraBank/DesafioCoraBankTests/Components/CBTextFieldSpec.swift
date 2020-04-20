//
//  CBTextFieldSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 20/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class CBTextFieldSpec: QuickSpec {
    override func spec() {
        
        let frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        
        describe("The login TextField") {
            
            it("should have an empty login state") {
                let textField = CBTextField(frame, type: .login)
                textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                textField.placeholderText = "Nome ou email"
                expect(textField) == snapshot("CBTextFieldLoginEmpty")
            }
            
            it("should have an fulfilled login state") {
                let textField = CBTextField(frame, type: .login)
                textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                textField.placeholderText = "Nome ou email"
                textField.text = "Lucas Vallim da Costa"
                expect(textField) == snapshot("CBTextFieldLoginFulfilled")
            }
            
            it("should have an empty password state") {
                let textField = CBTextField(frame, type: .password)
                textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                textField.placeholderText = "Senha"
                expect(textField) == snapshot("CBTextFieldPasswordEmpty")
            }
            
            it("should have an fulfilled password state") {
                let textField = CBTextField(frame, type: .password)
                textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                textField.placeholderText = "Senha"
                textField.text = "password"
                expect(textField) == snapshot("CBTextFieldPasswordFulfilled")
            }
            
            it("should have an open password state") {
                let textField = CBTextField(frame, type: .password)
                textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                textField.placeholderText = "Senha"
                textField.text = "password"
                textField.toogleSecurity()
                expect(textField) == snapshot("CBTextFieldPasswordOpen")
            }
        }
    }
}
