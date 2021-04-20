//
//  LoginViewModel.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

enum LoginViewModelState {
    case none
    case authenticating
    case authenticated
    case emailEmpty
    case passwordEmpty
    case emailAndPasswordEmpty
    case invalidEmail
    case wrongEmailAndPassword
}

protocol LoginViewModelProtocol {
    var email: String? { get set }
    var password: String? { get set }
    var onUpdated: ((LoginViewModelState) -> Void)? { get set }
    func login()
}

class LoginViewModel: LoginViewModelProtocol {
    var email: String?
    var password: String?

    var onUpdated: ((LoginViewModelState) -> Void)? {
        didSet {
            onUpdated?(state)
        }
    }

    var state = LoginViewModelState.none {
        didSet {
            DispatchQueue.main.async {
                self.onUpdated?(self.state)
            }
        }
    }

    private var loginUseCase: LoginUseCaseProtocol
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
        self.loginUseCase.presenter = self
    }

    func login() {
        if email?.isEmpty == true && password?.isEmpty == true {
            state = .emailAndPasswordEmpty
            return
        }

        guard email?.isEmpty == false else {
            state = .emailEmpty
            return
        }

        guard password?.isEmpty == false else {
            state = .passwordEmpty
            return
        }

        if let email = email, let password = password {
            self.loginUseCase.execute(email: email, password: password)
        }
    }
}

extension LoginViewModel: LoginPresenter {
    func authenticating() {
        state = .authenticating
    }

    func loginSuccess(user: User) {
        State.shared.user = user
        state = .authenticated
    }

    func loginError(error: LoginUseCaseError) {
        switch error {
        case .invalidEmail:
            state = .invalidEmail
        case .wrongEmailOrPassword:
            state = .wrongEmailAndPassword
        }
    }
}
