//
//  InvoiceModel.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 17/05/22.
//

import Foundation

// MARK: - Body
struct InvoiceModel: Codable {
    let invoiceResume: InvoiceResume?
    let mainTransactions: [Transaction]?
    let cards: [Card]?
}

// MARK: - Card
struct Card: Codable {
    let cardName, finalCardNumber: String
    let transactions: [Transaction]
}

// MARK: - Transaction
struct Transaction: Codable {
    let date: String
    let transactionDescription: String
    let value: Double
    let transactionType: TransactionType
    let observationDescription: String?
    let observationValue: Double?
    let observationCurrency: String?

    enum CodingKeys: String, CodingKey {
        case date
        case transactionDescription = "description"
        case value, transactionType, observationDescription, observationValue, observationCurrency
    }
}

enum TransactionType: String, Codable {
    case reversal = "reversal"
    case spent = "spent"
    case balance = "balance"
    case payment = "payment"
    case charges = "charges"
}

// MARK: - InvoiceResume
struct InvoiceResume: Codable {
    let chart: [Chart]
    let infos: Infos
}

// MARK: - Chart
struct Chart: Codable {
    let month: String
    let value: Float
}

// MARK: - Infos
struct Infos: Codable {
    let value: Double
    let totalValue: Int
    let expirationDate: String
}
