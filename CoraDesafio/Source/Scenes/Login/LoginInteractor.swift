//
//  LoginInteractor.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation
import CoreKit

protocol LoginInteracting: AnyObject {
    func didPop()
    func saveCpfOnMemory(_ cpf: String)
    func validateCpfInput(_ value: String)
}

final class LoginInteractor {
    
    // MARK: - Private Properties
    
    private let presenter: LoginPresenting
    
    // MARK: - Initialize
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
}
// MARK: - LoginInteracting

extension LoginInteractor: LoginInteracting {
    func validateCpfInput(_ value: String) {
        let isCpf = InputValidationHelper.shared.validateCPF(value)
        presenter.setEnableButton(isCpf)
    }
    
    func saveCpfOnMemory(_ cpf: String) {
        LoginBuilderHelper.shared.save(.document(cpf))
        presenter.showPasswordView()
    }
    
    func didPop() {
        presenter.didPop()
    }
}
