//
//  PasswordInteractor.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation
import CoreKit
import NetwokKit

protocol PasswordInteracting: AnyObject {
    func didPop()
    func validatePassword(_ value: String)
    func savePasswordOnMemory(_ value: String)
}

final class PasswordInteractor {
    
    // MARK: - Properties
    
    private let presenter: PasswordPresenting
    private let service: CoraServicing
    
    // MARK: - Initialize
    
    init(presenter: PasswordPresenting, service: CoraServicing) {
        self.presenter = presenter
        self.service = service
    }
}

// MARK: - PasswordInteracting

extension PasswordInteractor: PasswordInteracting {
    func savePasswordOnMemory(_ value: String) {
        LoginBuilderHelper.shared.save(.password(value))
        
        presenter.startLoadingButton()
        Task {
            do {
                guard let data = LoginBuilderHelper.shared.loginRequest else { throw BaseError.inputLoginDataError}
                let request = LoginRequest(cpf: data.cpf, password: data.password)
                let token = try await service.fetchLogin(request: request)
                
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    self.presenter.showExtractView(service: self.service)
                }
            
            } catch {
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    self.presenter.stopLoadingButton()
                }
            }
        }
    }
    
    func validatePassword(_ value: String) {
        let isPassword = InputValidationHelper.shared.validatePassword(value)
        presenter.setEnableButton(isPassword)
    }
    
    func didPop() {
        presenter.didPop()
    }
}
