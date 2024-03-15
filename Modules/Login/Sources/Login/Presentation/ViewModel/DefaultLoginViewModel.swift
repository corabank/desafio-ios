//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import Foundation
import Core

public class DefaultLoginViewModel: LoginViewModelProtocol {
    private let loginUseCase: LogUserUseCase
    
    public var onLoginSuccess: ((TokenRevalidationResponse) -> Void)?
    public var onLoginError: ((Error) -> Void)?
    
    public init(loginUseCase: LogUserUseCase) {
        self.loginUseCase = loginUseCase
    }

    public func didSubmit(login: LoginData) {
        loginUseCase.run(requestData: login) { [weak self] result in
            switch result {
            case .success(let data):
                self?.onLoginSuccess?(data)
            case .failure(let failure):
                self?.onLoginError?(failure)
            }
        }
    }
    
    public func isValid(cpf: String) -> Bool {
        return cpf
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: ".", with: "")
            .count == 11
    }
}
