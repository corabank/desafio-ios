//
//  LoginUseCase.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

public enum LoginUseCaseError: Error {
    case invalidEmail
    case wrongEmailOrPassword
}

//sourcery: AutoMockable
protocol LoginUseCaseProtocol {
    var presenter: LoginPresenter? { get set }
    func execute(email: String, password: String)
}

class LoginUseCase: LoginUseCaseProtocol {
    var presenter: LoginPresenter?
    let repository: LoginRepositoryProtocol

    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }

    func execute(email: String, password: String) {

        // Validating
        guard email.isValidEmail() else {
            presenter?.loginError(error: .invalidEmail)
            return
        }

        // starts loading
        self.presenter?.authenticating()

        // executes login repository process
        self.repository.login(email: email, password: password) { result in
            do {
                let user = try result.get()

                guard !user.email.isEmpty else {
                    self.presenter?.loginError(error: .wrongEmailOrPassword)
                    return
                }

                self.presenter?.loginSuccess(user: user)
            } catch {
                self.presenter?.loginError(error: .wrongEmailOrPassword)
            }
        }
    }
}
