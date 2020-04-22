//
//  CBActionButtonSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 20/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class CBActionButtonSpec: QuickSpec {
    override func spec() {
        describe("The Default Action Button") {
            it("should have the expected appearance") {
                let button = CBActionButton(frame: .zero)
                button.widthAnchor.constraint(equalToConstant: 300).isActive = true
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true
                button.title = "Acessar minha conta"
                expect(button) == snapshot("CBActionButton")
            }
            it("should not init with coder") {
                let button = CBActionButton(coder: NSCoder())
                expect(button).to(beNil())
            }
            it("should be tappable") {
                let button = CBActionButton()
                var tapped = false
                button.onTouch = {
                    tapped = true
                }
                button.handleTap()
                expect(tapped).to(beTrue())
            }
            it("should have an accessible title") {
                let button = CBActionButton()
                button.title = "Titulo"
                expect(button.title).to(be("Titulo"))
            }
        }
    }
}
