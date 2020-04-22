//
//  LoginLogoViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class LoginLogoViewSpec: QuickSpec {
    override func spec() {
        describe("The Logo View") {
            it("should have the expected appearance") {
                let logoView = LoginLogoView()
                logoView.widthAnchor.constraint(equalToConstant: 160).isActive = true
                logoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                expect(logoView) == snapshot("LoginLogoView")
            }
            
            it("should not init with coder") {
                let logoView = LoginLogoView(coder: NSCoder())
                expect(logoView).to(beNil())
            }
        }
    }
}
