//
//  LoginCoordinator.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation
import UIKit

enum LoginCoordinatorAction {
    case login
}

protocol LoginCoordinating {
    func perform(action: LoginCoordinatorAction)
    var viewController: UIViewController? { get set }
}

class LoginCoordinator: LoginCoordinating {
    
    weak var viewController: UIViewController?
    
    func perform(action: LoginCoordinatorAction) {
        if case .login = action {
            let vc = TransactionsListFactory.make()
            viewController?.present(vc, animated: true)
        }
    }
}
