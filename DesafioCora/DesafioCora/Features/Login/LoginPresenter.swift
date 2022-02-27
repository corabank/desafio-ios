//
//  LoginPresenter.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

protocol LoginPresenting {
    func presentLoading(_ loading: Bool)
    func presentError(_ error: ServiceError)
    func presentError(title: String, message: String)
    func presentSuccess(loginResponse: LoginResponse)
}

final class LoginPresenter {
    weak var viewController: LoginDisplaying?
    let coordinator: LoginCoordinating
    
    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
}

extension LoginPresenter: LoginPresenting {
    func presentLoading(_ loading: Bool) {
        viewController?.displayLoading(loading)
    }
    
    func presentError(_ error: ServiceError) {
        viewController?.displayError(title: "Ops!", message: error.localizedDescription)
    }
    
    func presentError(title: String, message: String) {
        viewController?.displayError(title: title, message: message)
    }
    
    func presentSuccess(loginResponse: LoginResponse) {
        coordinator.perform(action: .login)
    }
}
