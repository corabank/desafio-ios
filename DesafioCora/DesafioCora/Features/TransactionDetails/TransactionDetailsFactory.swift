//
//  TransactionDetailsFactory.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

enum TransactionDetailsFactory {
    static func make(transaction: TransactionModel) -> TransactionDetailsVewController {
        let presenter = TransactionDetailsPresenter()
        let interactor = TransactionDetailsInteractor(transaction: transaction, presenter: presenter)
        let viewController = TransactionDetailsVewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
