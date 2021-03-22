//
//  ExpenseList.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import Foundation

// MARK: - OrderList

struct OrderList: Codable {
    let orderList: [OrderListElement]
}

// MARK: - OrderListElement

struct OrderListElement: Codable {
    let value: Double?
    let mail: String?
    let status: Bool?
    let date: String?
    let ownerPurchase: String?
    let creationDate: String?
    let taxes: Double?
}
