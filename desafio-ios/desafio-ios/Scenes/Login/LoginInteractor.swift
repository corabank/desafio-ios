//
//  LoginInteractor.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import Foundation

protocol LoginInteracting: AnyObject {
    /**
     * Make login by Username and Password.
     *
     * It will manager what should be done when the user tries to login:
     *   - Loading
     *   - Error Label
     *   - Show Home Screen
     *
     *  - Parameter username: A username that will be used to user make login.
     *
     *  - Parameter password: A password that will be used to user make login.
     *
     */
    func didLogin(username: String?, password: String?)
}

final class LoginInteractor {
    
    private let presenter: LoginPresenting
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
}

// MARK: - LoginInteracting
extension LoginInteractor: LoginInteracting {
    func didLogin(username: String?, password: String?) {
        if let username = username, isUsernameValid(username: username) {
            if let password = password, isPassswordValid(password: password) {
                presenter.presentLoading(shouldPresent: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.presenter.didNextStep(action: .openHomeScreen)
                    self?.presenter.presentLoading(shouldPresent: false)
                }
            }
        } else {
            presenter.presentError()
        }
    }
    
    private func isUsernameValid(username: String) -> Bool {
        if username == "PeterParker" {
            return true
        } else {
            return false
        }
    }
    
    private func isPassswordValid(password: String) -> Bool {
        if password == "1234" {
            return true
        } else {
            return false
        }
    }
}
