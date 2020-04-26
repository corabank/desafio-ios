//
//  OrderListViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderListViewSpec: QuickSpec {
    override func spec() {
        describe("The Login View") {
            context("On an iPhone SE") {
                it("should have the expected appearance") {
                    let orderListView = OrderListView()
                    orderListView.navigationView.userName = "Lucas"
                    orderListView.navigationView.logoImage.isHidden = false
                    let order = OrderListEntity(orderCount: 320, orderTotalValue: 115345.45, orderList: nil)
                    let viewModel = OrderListHeaderViewModel(order)
                    orderListView.headerView.setup(viewModel)
                    orderListView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                    orderListView.heightAnchor.constraint(equalToConstant: 568).isActive = true
                    expect(orderListView) == snapshot("OrderListViewSE")
                }
            }
            
            context("On an iPhone 8") {
                it("should have the expected appearance") {
                    let orderListView = OrderListView()
                    orderListView.navigationView.userName = "Lucas"
                    orderListView.navigationView.logoImage.isHidden = false
                    let order = OrderListEntity(orderCount: 320, orderTotalValue: 115345.45, orderList: nil)
                    let viewModel = OrderListHeaderViewModel(order)
                    orderListView.headerView.setup(viewModel)
                    orderListView.widthAnchor.constraint(equalToConstant: 375).isActive = true
                    orderListView.heightAnchor.constraint(equalToConstant: 667).isActive = true
                    expect(orderListView) == snapshot("OrderListView8")
                }
            }
            
            context("On an iPhone 11") {
                it("should have the expected appearance") {
                    let orderListView = OrderListView()
                    orderListView.navigationView.userName = "Lucas"
                    orderListView.navigationView.logoImage.isHidden = false
                    let order = OrderListEntity(orderCount: 320, orderTotalValue: 115345.45, orderList: nil)
                    let viewModel = OrderListHeaderViewModel(order)
                    orderListView.headerView.setup(viewModel)
                    orderListView.widthAnchor.constraint(equalToConstant: 414).isActive = true
                    orderListView.heightAnchor.constraint(equalToConstant: 896).isActive = true
                    expect(orderListView) == snapshot("OrderListView11")
                }
            }
            
            context("On an iPhone 11 Pro Max") {
                it("should have the expected appearance") {
                    let orderListView = OrderListView()
                    orderListView.navigationView.userName = "Lucas"
                    orderListView.navigationView.logoImage.isHidden = false
                    let order = OrderListEntity(orderCount: 320, orderTotalValue: 115345.45, orderList: nil)
                    let viewModel = OrderListHeaderViewModel(order)
                    orderListView.headerView.setup(viewModel)
                    orderListView.widthAnchor.constraint(equalToConstant: 621).isActive = true
                    orderListView.heightAnchor.constraint(equalToConstant: 1344).isActive = true
                    expect(orderListView) == snapshot("OrderListView11ProMax")
                }
            }
            
            it("should not init with coder") {
                let orderListView = OrderListView(coder: NSCoder())
                expect(orderListView).to(beNil())
            }
        }
    }
}
