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

//sourcery: AutoMockable
protocol LoginViewModelProtocol {
    var email: String? { get set }
    var password: String? { get set }
    var onUpdated: ((LoginViewModelState) -> Void)? { get set }
    func login()
}

class LoginViewModel: LoginViewModelProtocol {
    var email: String?
    var password: String?

    /// Spreads state to controller
    var onUpdated: ((LoginViewModelState) -> Void)? {
        didSet {
            onUpdated?(state)
        }
    }

    /// Initialize current state and fires onUpdated propagation
    var state = LoginViewModelState.none {
        didSet {
            DispatchQueue.main.async {
                self.onUpdated?(self.state)
            }
        }
    }

    private var useCase: LoginUseCaseProtocol
    init(useCase: LoginUseCaseProtocol) {
        self.useCase = useCase
        self.useCase.presenter = self
    }

    /// Fires use case login
    func login() {
        
        // MARK: Validation
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
        
        // MARK: Runs use case
        if let email = email, let password = password {
            self.useCase.execute(email: email, password: password)
        }
    }
}

// MARK: Implements LoginPresenter protocol
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
