//
//  OrderDetailSectionHeaderViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderDetailSectionHeaderViewSpec: QuickSpec {
    override func spec() {
        describe("The Navigation View") {
            it("should have the expected appearance") {
                
                let viewModel = OrderDetailSectionHeaderViewModel(sectionTitle: "Financial summary")
                let sectionHeaderView = OrderDetailSectionHeaderView(frame: .zero)
                sectionHeaderView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                sectionHeaderView.heightAnchor.constraint(equalToConstant: 40).isActive = true
                sectionHeaderView.setup(viewModel)
                expect(sectionHeaderView) == snapshot("OrderDetailSectionHeaderView")
            }
            it("should not init with coder") {
                let sectionHeaderView = OrderDetailSectionHeaderView(coder: NSCoder())
                expect(sectionHeaderView).to(beNil())
            }
        }
    }
}

