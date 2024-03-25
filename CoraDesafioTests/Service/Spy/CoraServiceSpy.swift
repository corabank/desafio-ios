//
//  CoraServiceSpy.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
import CoreKit
import NetwokKit
@testable import CoraDesafio

final class CoraServiceSpy: CoraServicing {
    
    var fetchLoginRequest: LoginRequest?
    var fetchLoginCalled = 0
    func fetchLogin(request: LoginRequest) async throws -> Token {
        fetchLoginCalled = 1
        fetchLoginRequest = request
        
        return Token(token: "TESTE")
    }
    
    var updateTokenCalled = 0
    func updateToken() async throws {
        updateTokenCalled = 1
    }
    
    var fetchExtractListCalled = 0
    func fetchExtractList() async throws -> ExtractResponse {
        fetchExtractListCalled = 1
        return ExtractResponse.Mock.value
    }
    
    
    var fetchExtractDetailsValue: String?
    var fetchExtractDetailsCalled = 0
    func fetchExtractDetails(_ id: String) async throws -> ExtractDetailsResponse {
        fetchExtractDetailsCalled = 1
        fetchExtractDetailsValue = id
        return ExtractResponse.Mock.extractDetails
    }
}
