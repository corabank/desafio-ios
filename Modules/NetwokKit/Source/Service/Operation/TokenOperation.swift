//
//  TokenOperation.swift
//  NetwokKit
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

final class TokenOperation: BaseOperation {
    
    // MARK: - Properties
    
    var mainOperation: CoraServiceOperationing
    
    // MARK: - Initialize
    
    init(_ mainOperation: any CoraServiceOperationing) {
        self.mainOperation = mainOperation
    }
    
    // MARK: - Public Methods
    
    func updateToken() async throws {
        print("🛜 ------------------------------------------- 🛜")
        print("Fetching: <TOKEN>")
        let oldToken = try await mainOperation.getActualToken().convert(to: .body)
        let requestData = await mainOperation.buildRequestData(
            url: .auth,
            type: .post,
            parameters: oldToken
        )
        let newToken: Token = try await mainOperation.performRequest(data: requestData)
        
        print("🔴OLD TOKEN: \(oldToken.bodyParameters)\n🟢NEW TOKEN: \(newToken.token)")
        await mainOperation.updateToken(newToken)
    }
}
