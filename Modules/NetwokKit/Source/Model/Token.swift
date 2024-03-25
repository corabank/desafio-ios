//
//  Token.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

public struct Token: Codable {
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }

    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}
