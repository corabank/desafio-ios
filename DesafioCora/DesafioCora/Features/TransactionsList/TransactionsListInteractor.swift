//
//  TransactionsListInteractor.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

protocol TransactionsListInteracting {
    var transactions: [TransactionModel] { get }
    func loadTransactions()
    func select(transaction: Int)
}

final class TransactionsListInteractor {
    let service: TransactionsListServicing
    let presenter: TransactionsListPresenting
    
    private(set) var loadedTransactions: [TransactionModel] = []
    init(service: TransactionsListServicing, presenter: TransactionsListPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

extension TransactionsListInteractor: TransactionsListInteracting {
    var transactions: [TransactionModel] {
        loadedTransactions
    }
    
    func loadTransactions() {
        service.loadTransactions { [weak self] result in
            switch result {
            case .success(let transactions):
                self?.loadedTransactions = transactions
                self?.presenter.presentTransactionsList()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func select(transaction: Int) {
        presenter.presentDetailsFor(transaction: transactions[transaction])
    }
}
