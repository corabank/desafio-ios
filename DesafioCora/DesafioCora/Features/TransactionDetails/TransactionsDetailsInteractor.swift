//
//  TransactionsDetailsInteractor.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

protocol TransactionDetailsInteracting {
    func loadTransaction()
}

final class TransactionDetailsInteractor {
    let transaction: TransactionModel
    let presenter: TransactionDetailsPresenting
    
    init(transaction: TransactionModel, presenter: TransactionDetailsPresenting) {
        self.transaction = transaction
        self.presenter = presenter
    }
}

extension TransactionDetailsInteractor: TransactionDetailsInteracting {
    func loadTransaction() {
        presenter.presentTransaction(transaction)
    }
}
