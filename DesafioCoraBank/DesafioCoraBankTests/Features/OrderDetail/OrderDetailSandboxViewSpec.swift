//
//  OrderDetailSandboxViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderDetailSandboxViewSpec: QuickSpec {
    override func spec() {
        describe("The Sandbox View") {
            it("should have the expected appearance") {
                let viewModel = OrderDetailSandboxViewModel(sandbox: "sandbox: b463456nsd-3454353 345345 345345-345345 fiogsdgbjk3h45j6343")
                let sandboxView = OrderDetailSandboxView(frame: .zero)
                sandboxView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                sandboxView.heightAnchor.constraint(equalToConstant: 60).isActive = true
                sandboxView.setup(viewModel)
                expect(sandboxView) == snapshot("OrderDetailSandboxView")
            }
            it("should not init with coder") {
                let sandboxView = OrderDetailSandboxView(coder: NSCoder())
                expect(sandboxView).to(beNil())
            }
        }
    }
}


