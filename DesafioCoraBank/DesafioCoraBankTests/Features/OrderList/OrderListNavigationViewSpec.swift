//
//  OrderListNavigationViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderListNavigationViewSpec: QuickSpec {
    override func spec() {
        describe("The Navigation View") {
            it("should have the expected appearance") {
                let navigationView = OrderListNavigationView()
                navigationView.widthAnchor.constraint(equalToConstant: 300).isActive = true
                navigationView.heightAnchor.constraint(equalToConstant: 60).isActive = true
                navigationView.userName = "Lucas"
                navigationView.logoImage.isHidden = false
                expect(navigationView) == snapshot("OrderListNavigationView")
            }
            
            it("should not init with coder") {
                let navigationView = OrderListNavigationView(coder: NSCoder())
                expect(navigationView).to(beNil())
            }
        }
    }
}
