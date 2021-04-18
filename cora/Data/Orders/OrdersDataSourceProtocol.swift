//
//  OrdersDataSourceProtocol.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

//sourcery: AutoMockable
protocol OrdersDataSourceProtocol {
    func fetchOrders(completionHandler: @escaping (Result<[OrderDTO], Error>) -> Void)
}
