//
//  Order.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case paid
    case pending
    case late
}

struct Order: Identifiable {
    var id = UUID()
    var value: Double
    var description: String
    var dueDate: Date
    var status: OrderStatus
}
