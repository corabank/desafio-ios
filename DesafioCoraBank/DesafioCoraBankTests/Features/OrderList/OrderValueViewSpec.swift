//
//  OrderValueViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderValueViewSpec: QuickSpec {
    override func spec() {
        describe("The Order Value View") {
            it("should have the default appearance") {
                let order = OrderEntity(id: "abcdef123", value: 110.10, email: "email1@email.com", status: .paid, date: self.generateMockedDate(), paymentMethod: .credit, buyerName: "Caju Cacau", taxes: 4.99, sandbox: "1")
                let viewModel = OrderValueViewModel(order)
                let valueView = OrderValueView()
                valueView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                valueView.heightAnchor.constraint(equalToConstant: 64).isActive = true
                valueView.setup(viewModel)
                expect(valueView) == snapshot("OrderValueViewDefault")
            }
            
            it("should have the payment method appearance") {
                let order = OrderEntity(id: "abcdef123", value: 110.10, email: "email1@email.com", status: .paid, date: self.generateMockedDate(), paymentMethod: .credit, buyerName: "Caju Cacau", taxes: 4.99, sandbox: "1")
                let viewModel = OrderValueViewModel(order, showPaymentMethod: true)
                let valueView = OrderValueView()
                valueView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                valueView.heightAnchor.constraint(equalToConstant: 64).isActive = true
                valueView.setup(viewModel)
                expect(valueView) == snapshot("OrderValueViewPaymentMethod")
            }
            
            it("should not init with coder") {
                let valueView = OrderValueView(coder: NSCoder())
                expect(valueView).to(beNil())
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
