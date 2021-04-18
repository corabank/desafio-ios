//
//  OrdersRepositoryProtocol.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

//sourcery: AutoMockable
protocol OrdersRepositoryProtocol {
    func fetchOrders(completionHandler: @escaping (Result<[Order], Error>) -> Void)
}
