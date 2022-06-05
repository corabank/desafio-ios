//
//  ExtractModel.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

struct ExtractModel: Codable {
    let days: [ExtractDay]
}

struct ExtractDay: Codable {
    let day: String
    let balance: String
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let type: TransactionType
    let value: String
    let name: String
    let time: String
    let icon: String
    let description: String
}

enum TransactionType: String, Codable, CaseIterable {
    case entry
    case output
    case refund
}
