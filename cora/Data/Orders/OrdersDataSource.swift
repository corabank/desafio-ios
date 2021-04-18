//
//  OrdersDataSource.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

class OrdersDataSource: OrdersDataSourceProtocol {
    func fetchOrders(completionHandler: @escaping (Result<[OrderDTO], Error>) -> Void) {
        // call api
        // ...
        
        // fake data
        var orders = [OrderDTO]()
        
        for _ in 0...100 {
            orders.append(
                OrderDTO(
                    id: UUID().uuidString,
                    value: Double.random(in: 40.00...200.99),
                    description: "someemail@email.com",
                    dueDate: Date() - TimeInterval(Int.random(in: 100000...300000)),
                    status: OrderStatus.allCases.randomElement()?.rawValue ?? OrderStatus.paid.rawValue)
            )
        }

        completionHandler(.success(orders))
    }
}
