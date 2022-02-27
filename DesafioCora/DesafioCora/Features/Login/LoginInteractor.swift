//
//  LoginInteractor.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

protocol LoginInteracting {
    func login(username: String?, password: String?)
}

final class LoginInteractor {
    let service: LoginServicing
    let presenter: LoginPresenting
    
    init(service: LoginServicing, presenter: LoginPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

extension LoginInteractor: LoginInteracting {
    func login(username: String?, password: String?) {
        guard
            let username = username,
            let password = password,
            !username.isEmpty,
            !password.isEmpty else {
                presenter.presentError(title: "Ops!", message: "Informe os dados de acesso.")
            return
        }

        presenter.presentLoading(true)
        service.login(username: username, password: password) { [weak self] result in
            self?.presenter.presentLoading(false)
            
            switch result {
            case .success(let response):
                self?.presenter.presentSuccess(loginResponse: response)
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }
}
