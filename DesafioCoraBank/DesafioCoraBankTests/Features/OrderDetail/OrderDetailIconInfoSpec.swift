//
//  OrderDetailIconInfoSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderDetailIconInfoSpec: QuickSpec {
    override func spec() {
        describe("The Icon Info View") {
            it("should have the buyer appearance") {
                let viewModel = OrderDetailIconInfoViewModel(iconImageName: "icon-login", fieldText: "order_buyer".localized, valueText: "Caju Cacau", valueColor: .cbBlack)
                let iconInfoView = OrderDetailIconInfoView()
                iconInfoView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                iconInfoView.heightAnchor.constraint(equalToConstant: 64).isActive = true
                iconInfoView.setup(viewModel)
                expect(iconInfoView) == snapshot("OrderDetailIconInfoBuyer")
            }
            
            it("should have the email appearance") {
                let viewModel = OrderDetailIconInfoViewModel(iconImageName: "icon-email", fieldText: "order_email".localized, valueText: "email1@email.com", valueColor: .cbBlack)
                let iconInfoView = OrderDetailIconInfoView()
                iconInfoView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                iconInfoView.heightAnchor.constraint(equalToConstant: 64).isActive = true
                iconInfoView.setup(viewModel)
                expect(iconInfoView) == snapshot("OrderDetailIconInfoEmail")
            }
            
            it("should have the date appearance") {
                let viewModel = OrderDetailIconInfoViewModel(iconImageName: "icon-calendar", fieldText: "order_created_at".localized, valueText: "03/08/2018", valueColor: .cbBlack)
                let iconInfoView = OrderDetailIconInfoView()
                iconInfoView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                iconInfoView.heightAnchor.constraint(equalToConstant: 64).isActive = true
                iconInfoView.setup(viewModel)
                expect(iconInfoView) == snapshot("OrderDetailIconInfoDate")
            }
            
            it("should have the status appearance") {
                let viewModel = OrderDetailIconInfoViewModel(iconImageName: "icon-watch", fieldText: "order_status".localized, valueText: "Pago", valueColor: .cbGreen)
                let iconInfoView = OrderDetailIconInfoView()
                iconInfoView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                iconInfoView.heightAnchor.constraint(equalToConstant: 64).isActive = true
                iconInfoView.setup(viewModel)
                expect(iconInfoView) == snapshot("OrderDetailIconInfoStatus")
            }
            
            it("should not init with coder") {
                let iconInfoView = OrderDetailIconInfoView(coder: NSCoder())
                expect(iconInfoView).to(beNil())
            }
        }
    }
    
    private func generateMockedDate() -> Date {
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -3
        let date = gregorian?.date(byAdding: offsetComponents, to: Date(), options: .init(rawValue: 0) )
        return date ?? Date()
    }
}

