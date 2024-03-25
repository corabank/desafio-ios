//
//  LoginOperation.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation
import CoreKit

final class LoginOperation: BaseOperation {
    
    // MARK: - Properties
    
    var mainOperation: CoraServiceOperationing
    private let requestData: LoginRequest
    
    // MARK: - Initialize
    
    init(_ mainOperation: CoraServiceOperationing, requestData: LoginRequest) {
        self.mainOperation = mainOperation
        self.requestData = requestData
    }
    
    // MARK: - Public Methods
    
    func fetchLogin() async throws -> Token {
        let body = try requestData.convert(to: .body)
        async let requestData = mainOperation.buildRequestData(
            url: .auth,
            type: .post, 
            parameters: body
        )
        
        let token: Token = try await mainOperation.performRequest(data: requestData)
        await mainOperation.updateToken(token)
        return token
    }
}
