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

enum PaymentType: String, CaseIterable {
    case credit
    case debit
    case pix
    case billet
}

struct Order: Identifiable {
    var id = UUID()
    var value: Double
    var taxes: Double
    var description: String
    var createdAt: Date
    var dueDate: Date
    var status: OrderStatus
    var paymentType: PaymentType
    var buyerName: String
    var buyerEmail: String
}
