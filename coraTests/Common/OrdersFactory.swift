//
//  OrdersFactory.swift
//  coraTests
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation
@testable import cora

class OrdersFactory {
    static func createDTO() -> [OrderDTO] {
        var factory = [OrderDTO]()
        
        for _ in 1...100 {
            factory.append(OrderDTO(
                    id: UUID().uuidString,
                    value: Double.random(in: 40.00...200.99),
                    taxes: Double.random(in: 1.99...5.99),
                    description: "someemail@email.com",
                    createdAt: Date() - TimeInterval(Int.random(in: 300000...800000)),
                    dueDate: Date() - TimeInterval(Int.random(in: 100000...300000)),
                    status: OrderStatus.allCases.randomElement()?.rawValue ?? OrderStatus.paid.rawValue,
                    paymentType: ["credit", "debit", "pix", "billet"].randomElement()?.description ?? "",
                    buyerName: ["George Cloney", "Batman", "Skeletor", "MunRa"].randomElement()?.description ?? "",
                    buyerEmail: ["george@cloney.com", "darkbegins@batman.com", "greyskull@skeletor.com", "munra@gmail.com"].randomElement()?.description ?? ""
                )
            )
        }
        
        return factory
    }
    
    static func create() -> [Order] {
        var factory = [Order]()
        
        for _ in 1...100 {
            factory.append(Order(
                    value: Double.random(in: 40.00...200.99),
                    taxes: Double.random(in: 1.99...5.99),
                    description: "someemail@email.com",
                    createdAt: Date() - TimeInterval(Int.random(in: 300000...800000)),
                    dueDate: Date() - TimeInterval(Int.random(in: 100000...300000)),
                    status: OrderStatus.allCases.randomElement() ?? OrderStatus.paid,
                    paymentType: PaymentType.allCases.randomElement() ?? PaymentType.credit,
                    buyerName: ["George Cloney", "Batman", "Skeletor", "MunRa"].randomElement()?.description ?? "",
                    buyerEmail: ["george@cloney.com", "darkbegins@batman.com", "greyskull@skeletor.com", "munra@gmail.com"].randomElement()?.description ?? ""
                )
            )
        }
        return factory
    }
}
