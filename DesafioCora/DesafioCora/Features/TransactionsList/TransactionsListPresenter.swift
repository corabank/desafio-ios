//
//  TransactionsListPresenter.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

protocol TransactionsListPresenting {
    func presentTransactionsList()
    func presentDetailsFor(transaction: TransactionModel)
}

final class TransactionsListPresenter {
    weak var viewController: TransactionsListDisplaying?
    let coordinator: TransactionsListCoordinating
    
    init(coordinator: TransactionsListCoordinating) {
        self.coordinator = coordinator
    }
}

extension TransactionsListPresenter: TransactionsListPresenting {
    func presentTransactionsList() {
        viewController?.displayTransactions()
    }
    
    func presentDetailsFor(transaction: TransactionModel) {
        coordinator.perform(action: .detail(transaction))
    }
}
