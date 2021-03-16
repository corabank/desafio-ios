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
    let statusCode: Int
}

// MARK: - OrderListElement
struct OrderListElement: Codable {
    let value: Int
    let mail: String
    let status: Bool
    let date: String
    let details: Details?
}

// MARK: - Details
struct Details: Codable {
    let value: Int
    let ownerPurchase, ownerMail, creationDate: String
    let ownerStatus: Bool
    let taxes: Double
}
