//
//  CoraService.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation
import CoreKit

public protocol CoraServicing {
    func fetchLogin(request: LoginRequest) async throws -> Token
    func updateToken() async throws
    func fetchExtractList() async throws -> ExtractResponse
    func fetchExtractDetails(_ id: String)  async throws -> ExtractDetailsResponse
}

public final class CoraService {
    
    // MARK: - Properties
    
    private let mainOperation: CoraServiceOperationing
    
    // MARK: - Initialize
    
    public init() {
        self.mainOperation = CoraServiceOperation()
    }
}

// MARK: - CoraServicing

extension CoraService: CoraServicing {
    public func fetchLogin(request: LoginRequest) async throws -> Token {
        let operation = LoginOperation(mainOperation, requestData: request)
        return try await operation.fetchLogin()
    }
    
    public func updateToken() async throws {
        let operation = TokenOperation(mainOperation)
        try await operation.updateToken()
    }
    
    public func fetchExtractList() async throws -> ExtractResponse {
        let operation = ExtractListOperation(mainOperation)
        return try await operation.fetchAllExtract()
    }
    
    public func fetchExtractDetails(_ id: String)  async throws -> ExtractDetailsResponse {
        let operation = ExtractListOperation(mainOperation)
        return try await operation.fetchExtractDetails(id: id)
    }
}
