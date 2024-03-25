//
//  LoginPresenter.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation

protocol LoginPresenting: AnyObject {
    var viewController: LoginDisplaying? { get set }
    
    func didPop()
    func showPasswordView()
    func setEnableButton(_ isEnable: Bool)
}

final class LoginPresenter {
    
    // MARK: - Properties
    
    weak var viewController: LoginDisplaying?
    private let coordinator: OnboardingCoordinating
    
    // MARK: - Initialize
    
    init(coordinator: OnboardingCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - LoginPresenting

extension LoginPresenter: LoginPresenting {
    func setEnableButton(_ isEnable: Bool) {
        viewController?.setEnableButton(isEnable)
    }
    
    func showPasswordView() {
        coordinator.perform(to: .password)
    }
    
    func didPop() {
        coordinator.pop()
    }
}
