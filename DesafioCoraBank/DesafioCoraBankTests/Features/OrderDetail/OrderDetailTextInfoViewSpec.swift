//
//  OrderDetailTextInfoViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderDetailTextInfoViewSpec: QuickSpec {
    override func spec() {
        describe("The Navigation View") {
            it("should have a black version") {
                let viewModel = OrderDetailTextInfoViewModel(size: .regular, fieldText: "Total Value", currency: "R$", valueText: "110.10", fontColor: .cbBlack)
                let textInfoView = OrderDetailTextInfoView(frame: .zero)
                textInfoView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                textInfoView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                textInfoView.setup(viewModel)
                expect(textInfoView) == snapshot("OrderDetailTextInfoViewBlack")
            }
            it("should have a red version") {
                let viewModel = OrderDetailTextInfoViewModel(size: .regular, fieldText: "Taxes", currency: "R$", valueText: "4.99", fontColor: .cbRed)
                let textInfoView = OrderDetailTextInfoView(frame: .zero)
                textInfoView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                textInfoView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                textInfoView.setup(viewModel)
                expect(textInfoView) == snapshot("OrderDetailTextInfoViewRed")
            }
            it("should have a blue version") {
                let viewModel = OrderDetailTextInfoViewModel(size: .big, fieldText: "My receipt", currency: "R$", valueText: "105.01", fontColor: .cbLightBlue)
                let textInfoView = OrderDetailTextInfoView(frame: .zero)
                textInfoView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                textInfoView.heightAnchor.constraint(equalToConstant: 40).isActive = true
                textInfoView.setup(viewModel)
                expect(textInfoView) == snapshot("OrderDetailTextInfoViewBlue")
            }
            it("should not init with coder") {
                let textInfoView = OrderDetailTextInfoView(coder: NSCoder())
                expect(textInfoView).to(beNil())
            }
        }
    }
}


