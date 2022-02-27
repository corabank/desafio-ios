//
//  TransactionModel.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

enum PaymentStatus: String, Decodable {
    case paid
    case waiting
    case notPaid
    
    var description: String {
        switch self {
        case .paid: return "Pago"
        case .waiting: return "Aguardando"
        case .notPaid: return "Nao pago"
        }
    }
    
    var color: UIColor {
        switch self {
            case .paid: return .green
            case .notPaid: return .red
            case .waiting: return .blue
        }
    }
}


enum PaymentType: String, Decodable {
    case creditCard
    case pix
    
    var description: String {
        switch self {
        case .creditCard: return "Cartao de credito"
        case .pix: return "Pix"
        }
    }
}

struct TransactionModel: Decodable {
    let value: Double
    let userName: String
    let userEmail: String
    let paymentStatus: PaymentStatus
    let paymentType: PaymentType
    let transactionDate: Date
    let tax: Double
    let id: String
    
}

// Mocked Sample Data
extension TransactionModel {
    static func sampleData() -> [TransactionModel] {
        return [
            TransactionModel(value: 110.0, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .paid, paymentType: .creditCard, transactionDate: .dateFrom("26/02/2022"), tax: 4.99, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 199.90, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .paid, paymentType: .creditCard, transactionDate: .dateFrom("25/02/2022"), tax: 8.92, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 25.80, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .notPaid, paymentType: .creditCard, transactionDate: .dateFrom("24/02/2022"), tax: 1.23, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 45.0, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .paid, paymentType: .creditCard, transactionDate: .dateFrom("24/02/2022"), tax: 2.57, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 110.0, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .waiting, paymentType: .creditCard, transactionDate: .dateFrom("24/02/2022"), tax: 4.99, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 330.46, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .waiting, paymentType: .creditCard, transactionDate: .dateFrom("22/02/2022"), tax: 15.45, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 245.10, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .notPaid, paymentType: .creditCard, transactionDate: .dateFrom("22/02/2022"), tax: 10.67, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 27.80, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .notPaid, paymentType: .creditCard, transactionDate: .dateFrom("22/02/2022"), tax: 0.78, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 99.30, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .waiting, paymentType: .creditCard, transactionDate: .dateFrom("22/02/2022"), tax: 4.35, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45"),
            TransactionModel(value: 110.0, userName: "Cacu Cacau", userEmail: "cacucacau@moip.com.br", paymentStatus: .paid, paymentType: .creditCard, transactionDate: .dateFrom("22/02/2022"), tax: 4.99, id: "sandbox: b4619238mns-1287413 41231231 131231-338741 fhagnuen39sd45")
            
        ]
    }
}
