//
//  ExtractListOperation.swift
//  NetwokKit
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation
import CoreKit

final class ExtractListOperation: BaseOperation {
    
    // MARK: - Properties
    
    var mainOperation: CoraServiceOperationing
    
    // MARK: - Initialize
    
    init(_ mainOperation: any CoraServiceOperationing) {
        self.mainOperation = mainOperation
    }
    
    // MARK: - Public Methods
    
    func fetchAllExtract() async throws -> ExtractResponse {
        let requestData = await mainOperation.buildRequestData(
            url: .extractList,
            type: .get,
            parameters: nil
        )
        
        print("Token: \(await mainOperation.getActualToken().token)")
        
        return try await mainOperation.performRequest(data: requestData)
    }
    
    func fetchExtractDetails(id: String) async throws -> ExtractDetailsResponse {
        let requestData = await mainOperation.buildRequestData(
            url: .extractDetails(id),
            type: .get,
            parameters: nil
        )
        
        return try await mainOperation.performRequest(data: requestData)
    }
}
