//
//  OrdersRepository.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

class OrdersRepository: OrdersRepositoryProtocol {
    private let ordersDataSource: OrdersDataSourceProtocol

    init(ordersDataSource: OrdersDataSourceProtocol) {
        self.ordersDataSource = ordersDataSource
    }

    func fetchOrders(completionHandler: @escaping (Result<[Order], Error>) -> Void) {
        self.ordersDataSource.fetchOrders { result in
            do {
                let ordersDTO = try result.get()
                let orders = ordersDTO.map { Order.init(orderDTO: $0) }
                completionHandler(.success(orders))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
