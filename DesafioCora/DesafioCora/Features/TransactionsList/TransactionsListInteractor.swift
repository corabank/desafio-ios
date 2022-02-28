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
                self?.parseError(serviceError: error)
            }
        }
    }
    
    func select(transaction: Int) {
        guard transaction >= 0 && transaction <= transactions.count else { return }
        presenter.presentDetailsFor(transaction: transactions[transaction])
    }
    
    private func parseError(serviceError: ServiceError) {
        // Check the error - Very simplified
        switch serviceError {
        case .requestError(let serviceErrorData):
            presenter.presentError(title: serviceErrorData.title, message: serviceErrorData.message)
        default:
            presenter.presentError(title: "Ops!", message: serviceError.localizedDescription)
        }
    }
}
