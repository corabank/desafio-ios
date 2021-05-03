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
        taxes = orderDTO.taxes
        description = orderDTO.description
        createdAt = orderDTO.createdAt
        dueDate = orderDTO.dueDate
        status = OrderStatus.allCases.first(where: { $0.rawValue == orderDTO.status }) ?? .pending
        paymentType = PaymentType.allCases.first(where: { $0.rawValue == orderDTO.paymentType }) ?? .credit
        buyerName = orderDTO.buyerName
        buyerEmail = orderDTO.buyerEmail
    }
}
