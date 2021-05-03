//
//  OrdersRepository.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

class OrdersRepository: OrdersRepositoryProtocol {
    private let dataSource: OrdersDataSourceProtocol

    init(dataSource: OrdersDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func fetchOrders(userID: UUID, completionHandler: @escaping (Result<[Order], Error>) -> Void) {
        self.dataSource.fetchOrders(userID: userID) { result in
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
