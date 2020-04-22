//
//  CBLoadingSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 22/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class CBLoadingSpec: QuickSpec {
    override func spec() {
        describe("The Default Loading") {
            it("should have the expected appearance") {
                let loading = CBLoading()
                loading.widthAnchor.constraint(equalToConstant: 320).isActive = true
                loading.heightAnchor.constraint(equalToConstant: 568).isActive = true
                expect(loading) == snapshot("CBLoading")
            }
            it("should not init with coder") {
                let loading = CBLoading(coder: NSCoder())
                expect(loading).to(beNil())
            }
        }
    }
}
