//
//  TransactionModel.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

enum PaymentType: String {
    case paid = "Pago"
    case waiting = "Aguardando"
    case notPaid = "Não Pago"
    
    var color: UIColor {
        switch self {
            case .paid: return .green
            case .notPaid: return .red
            case .waiting: return .blue
        }
    }
}

struct TransactionModel {
    let value: String
    let userMail: String
    let timeStamp: String
    let paymentType: PaymentType
}
