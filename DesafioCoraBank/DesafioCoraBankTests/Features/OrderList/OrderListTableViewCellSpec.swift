//
//  OrderListTableViewCellSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class OrderListTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("The Order Cell") {
            it("should have the expected appearance") {
                let order = OrderEntity(id: "abcdef123", value: 110.10, email: "email1@email.com", status: .paid, date: self.generateMockedDate(), paymentMethod: .credit, buyerName: "Caju Cacau", taxes: 4.99, sandbox: "1")
                let viewModel = OrderValueViewModel(order)
                let cellView = OrderListTableViewCell(style: .default, reuseIdentifier: "cell")
                cellView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                cellView.heightAnchor.constraint(equalToConstant: 64).isActive = true
                cellView.frame = CGRect(x: 0, y: 0, width: 320, height: 64)
                cellView.contentView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                cellView.contentView.heightAnchor.constraint(equalToConstant: 64).isActive = true
                cellView.contentView.frame = CGRect(x: 0, y: 0, width: 320, height: 64)
                cellView.setup(viewModel)
                expect(cellView) == snapshot("OrderListTableViewCellDefault")
            }
            
            it("should not init with coder") {
                let cellView = OrderListTableViewCell(coder: NSCoder())
                expect(cellView).to(beNil())
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

