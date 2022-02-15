//
//  LoginCoordinator.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import UIKit

enum LoginAction {
    case openHomeScreen
}

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: LoginAction)
}

final class LoginCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - LoginCoordinating
extension LoginCoordinator: LoginCoordinating {
    func perform(action: LoginAction) {
        switch action {
        case .openHomeScreen:
            let homeController = HomeFactory.make()
            viewController?.navigationController?.pushViewController(homeController, animated: true)
        }
    }
}
