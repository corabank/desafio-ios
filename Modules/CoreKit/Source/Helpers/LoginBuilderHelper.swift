//
//  LoginBuilderHelper.swift
//  CoreKit
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation

public typealias LoginBuilderType = LoginBuilderHelper.LoginType

public class LoginBuilderHelper {
    
    // MARK: - Public Properties
    
    public static let shared = LoginBuilderHelper()
    public var loginRequest: LoginRequest?
    
    // MARK: - Private Properties
    
    private var document: String?
    
    // MARK: - Public Properties
    
    public func save(_ loginType: LoginBuilderType) {
        switch loginType {
        case let .document(value):
            self.document = value
        case let .password(value):
            self.loginRequest = LoginRequest(cpf: document ?? "", password: value)
        }
    }
    
    public func setValue() {
        self.document = nil
        self.loginRequest = nil
    }
}

extension LoginBuilderHelper {
    public enum LoginType {
        case document(_ value: String)
        case password(_ value: String)
    }
}
