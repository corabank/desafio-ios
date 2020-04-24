//
//  OrderListHeaderViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderListHeaderViewSpec: QuickSpec {
    override func spec() {
        describe("The Header View") {
            it("should have the expected appearance") {
                let order = OrderListEntity(orderCount: 320, orderTotalValue: 115345.45, orderList: nil)
                let viewModel = OrderListHeaderViewModel(order)
                let navigationView = OrderListHeaderView(viewModel: viewModel)
                navigationView.widthAnchor.constraint(equalToConstant: 300).isActive = true
                navigationView.heightAnchor.constraint(equalToConstant: 77).isActive = true
                expect(navigationView) == snapshot("OrderListHeaderView")
            }
            
            it("should not init with coder") {
                let navigationView = OrderListHeaderView(coder: NSCoder())
                expect(navigationView).to(beNil())
            }
        }
    }
}

