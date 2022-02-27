//
//  TransactionsListCoordinator.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

enum TransactionsListCoordinatorAction {
    case detail(TransactionModel)
}

protocol TransactionsListCoordinating {
    var viewController: UIViewController? { get set }
    func perform(action: TransactionsListCoordinatorAction)
}

final class TransactionsListCoordinator {
    weak var viewController: UIViewController?
}

extension TransactionsListCoordinator: TransactionsListCoordinating {
    func perform(action: TransactionsListCoordinatorAction) {
        if case let .detail(transaction) = action {
            print("Detalhes: \(transaction.value.currency)")
            let vc = TransactionDetailsFactory.make(transaction: transaction)
            let navigation = UINavigationController(rootViewController: vc)
            viewController?.present(navigation, animated: true)
        }
    }
}
