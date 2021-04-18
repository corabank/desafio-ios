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
    var description: String
    var dueDate: Date
    var status: String
}
