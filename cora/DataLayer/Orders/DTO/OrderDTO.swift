//
//  OrdersDTO.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

struct OrderDTO: Codable {
    var id: String
    var value: Double
    var taxes: Double
    var description: String
    var createdAt: Date
    var dueDate: Date
    var status: String
    var paymentType: String
    var buyerName: String
    var buyerEmail: String
}
