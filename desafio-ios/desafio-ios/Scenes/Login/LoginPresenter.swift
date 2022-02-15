//
//  LoginPresenter.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import Foundation

protocol LoginPresenting: AnyObject {
    var viewController: LoginDisplaying? { get set }
    func didNextStep(action: LoginAction)
    func presentError()
    func presentLoading(shouldPresent: Bool)
}

final class LoginPresenter {

    private let coordinator: LoginCoordinating
    weak var viewController: LoginDisplaying?

    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - LoginPresenting
extension LoginPresenter: LoginPresenting {
    func didNextStep(action: LoginAction) {
        coordinator.perform(action: action)
    }
    
    func presentError() {
        viewController?.loginValidation()
    }
    
    func presentLoading(shouldPresent: Bool) {
        shouldPresent ? viewController?.startLoading() : viewController?.stopLoading()
    }
}
