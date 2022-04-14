//
//  TransactionText.swift
//  desafio-cora
//
//  Created by Matheus Perez on 14/04/22.
//

enum TransactionText {
    case text(transaction: TransactionDetail)
    
    func getText() -> String {
        switch self {
        case .text(let transaction):
            var text: String = ""
            switch transaction.transactionStatus.transactionType {
            case .transfer:
                if transaction.transactionStatus.status == .complete,
                   transaction.transactionStatus.transactionEntry == .input {
                    text = Strings.transferRecieved
                } else if transaction.transactionStatus.status == .reversed,
                          transaction.transactionStatus.transactionEntry == .output {
                    text = Strings.transferReversed
                } else if transaction.transactionStatus.status == .complete,
                          transaction.transactionStatus.transactionEntry == .output {
                    text = Strings.transferSent
                } else {
                    text = Strings.transferScheduled
                }
            case .payment:
                if transaction.transactionStatus.status == .complete,
                   transaction.transactionStatus.transactionEntry == .input {
                    text = Strings.paymentRecieved
                } else {
                    text = Strings.paymentReversed
                }
            case .ticket:
                if transaction.transactionStatus.status == .complete,
                   transaction.transactionStatus.transactionEntry == .input {
                    text = Strings.ticketDeposit
                } else {
                    text = Strings.ticketPaid
                }
            }
            return text
        }
    }
}
