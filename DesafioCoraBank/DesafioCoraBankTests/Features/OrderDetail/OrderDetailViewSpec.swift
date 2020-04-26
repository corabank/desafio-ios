//
//  OrderDetailViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 25/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderDetailViewSpec: QuickSpec {
    override func spec() {
        describe("The Login View") {
            context("On an iPhone SE") {
                it("should have the expected appearance") {
                    let orderDetailView = OrderDetailView()
                    orderDetailView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                    orderDetailView.heightAnchor.constraint(equalToConstant: 568).isActive = true
                    expect(orderDetailView) == snapshot("OrderDetailViewSE")
                }
            }
            
            context("On an iPhone 8") {
                it("should have the expected appearance") {
                    let orderDetailView = OrderDetailView()
                    orderDetailView.widthAnchor.constraint(equalToConstant: 375).isActive = true
                    orderDetailView.heightAnchor.constraint(equalToConstant: 667).isActive = true
                    expect(orderDetailView) == snapshot("OrderDetailView8")
                }
            }
            
            context("On an iPhone 11") {
                it("should have the expected appearance") {
                    let orderDetailView = OrderDetailView()
                    orderDetailView.widthAnchor.constraint(equalToConstant: 414).isActive = true
                    orderDetailView.heightAnchor.constraint(equalToConstant: 896).isActive = true
                    expect(orderDetailView) == snapshot("OrderDetailView11")
                }
            }
            
            context("On an iPhone 11 Pro Max") {
                it("should have the expected appearance") {
                    let orderDetailView = OrderDetailView()
                    orderDetailView.widthAnchor.constraint(equalToConstant: 621).isActive = true
                    orderDetailView.heightAnchor.constraint(equalToConstant: 1344).isActive = true
                    expect(orderDetailView) == snapshot("OrderDetailView11ProMax")
                }
            }
            
            it("should not init with coder") {
                let orderDetailView = OrderDetailView(coder: NSCoder())
                expect(orderDetailView).to(beNil())
            }
        }
    }
}

