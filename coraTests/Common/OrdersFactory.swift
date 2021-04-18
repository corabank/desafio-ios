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
        
        for _ in 0...100 {
            factory.append(OrderDTO(
                            id: UUID().uuidString,
                            value: Double.random(in: 40.00...200.99),
                            description: "someemail@email.com",
                            dueDate: Date() - TimeInterval(Int.random(in: 100000...300000)),
                            status: OrderStatus.allCases.randomElement()?.rawValue ?? OrderStatus.paid.rawValue))
        }
        
        return factory
    }
    
    
    static func create() -> [Order] {
        var factory = [Order]()
        
        for _ in 0...100 {
            factory.append(Order(
                            value: Double.random(in: 40.00...200.99),
                            description: "someemail@email.com",
                            dueDate: Date() - TimeInterval(Int.random(in: 100000...300000)),
                            status: OrderStatus.allCases.randomElement() ?? OrderStatus.paid))
        }
        
        return factory
    }
}
