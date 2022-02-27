//
//  TransactionDetailsPresenter.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

protocol TransactionDetailsPresenting {
    func presentTransaction(_ transaction: TransactionModel)
}

final class TransactionDetailsPresenter {
    weak var viewController: TransactionDetailsDisplaying?
}

extension TransactionDetailsPresenter: TransactionDetailsPresenting {
    func presentTransaction(_ transaction: TransactionModel) {
        viewController?.displayTransaction(transaction)
    }
}
