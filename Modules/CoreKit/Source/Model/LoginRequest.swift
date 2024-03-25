//
//  LoginRequest.swift
//  CoreKit
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation

public struct LoginRequest: Encodable {
    
    public let cpf: String
    public let password: String
    
    public init(cpf: String, password: String) {
        self.cpf = cpf
        self.password = password
    }
}
