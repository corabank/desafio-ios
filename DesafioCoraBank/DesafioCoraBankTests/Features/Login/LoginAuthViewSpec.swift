//
//  LoginAuthViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class LoginAuthViewSpec: QuickSpec {
    override func spec() {
        describe("The Auth View") {
            it("should have an empty state") {
                let authView = LoginAuthView()
                authView.widthAnchor.constraint(equalToConstant: 300).isActive = true
                authView.heightAnchor.constraint(equalToConstant: 140).isActive = true
                expect(authView) == snapshot("LoginAuthView")
            }
            
            it("should have an error state") {
                let authView = LoginAuthView()
                authView.errorText = "Usuário ou senha inválidos"
                authView.widthAnchor.constraint(equalToConstant: 300).isActive = true
                authView.heightAnchor.constraint(equalToConstant: 140).isActive = true
                expect(authView) == snapshot("LoginAuthViewError")
            }
            
            it("should not init with coder") {
                let authView = LoginAuthView(coder: NSCoder())
                expect(authView).to(beNil())
            }
        }
    }
}
