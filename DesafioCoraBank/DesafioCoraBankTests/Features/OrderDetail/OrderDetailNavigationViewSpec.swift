//
//  OrderDetailNavigationViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderDetailNavigationViewSpec: QuickSpec {
    override func spec() {
        describe("The Navigation View") {
            it("should have the expected appearance") {
                let navigationView = OrderDetailNavigationView(frame: .zero)
                navigationView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                navigationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                navigationView.title = "Voltar"
                expect(navigationView) == snapshot("OrderDetailNavigationView")
            }
            it("should not init with coder") {
                let navigationView = OrderDetailNavigationView(coder: NSCoder())
                expect(navigationView).to(beNil())
            }
            it("should be tappable") {
                let navigationView = OrderDetailNavigationView()
                var tapped = false
                navigationView.onTouch = {
                    tapped = true
                }
                navigationView.handleTap()
                expect(tapped).to(beTrue())
            }
            it("should have an accessible title") {
                let navigationView = OrderDetailNavigationView()
                navigationView.title = "Voltar"
                expect(navigationView.title).to(be("Voltar"))
            }
        }
    }
}
