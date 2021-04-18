//
//  Order+initWithOrderDTO.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

extension Order {
    init(orderDTO: OrderDTO) {
        value = orderDTO.value
        description = orderDTO.description
        dueDate = orderDTO.dueDate
        status = OrderStatus.allCases.first(where: { $0.rawValue == orderDTO.status }) ?? .pending
    }
}
