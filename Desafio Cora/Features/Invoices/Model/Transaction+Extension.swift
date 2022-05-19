//
//  Transaction+Extension.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 18/05/22.
//

import UIKit

extension Transaction {
    func textColor() -> UIColor {
        switch self.transactionType {
        case .payment:
            return .secondaryLight
        default:
            return .offBlack
        }
    }
}

extension InvoiceModel {
    var dataForTable: [Card] {
        var cards = [Card]()
        cards.append(Card(cardName: "", finalCardNumber: "", transactions: self.mainTransactions ?? [] ))
        for card in self.cards ?? [] {
            cards.append(card)
        }
        return cards
    }
    func formatDataForTable() -> [Card] {
        var cards = [Card]()
        cards.append(Card(cardName: "", finalCardNumber: "", transactions: self.mainTransactions ?? [] ))
        for card in self.cards ?? [] {
            cards.append(card)
        }
        return cards
    }
}
