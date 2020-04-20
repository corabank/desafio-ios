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
        }
    }
}
