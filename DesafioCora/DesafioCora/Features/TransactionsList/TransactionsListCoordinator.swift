//
//  TransactionsListCoordinator.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

enum TransactionsListCoordinatorAction {
    case detail
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
        if case .detail = action {
            print("Detalhes")
        }
    }
}
