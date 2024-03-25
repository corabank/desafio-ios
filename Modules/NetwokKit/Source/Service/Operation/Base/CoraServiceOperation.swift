//
//  CoraServiceOperation.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation
import CoreKit

protocol CoraServiceOperationing {
    func buildRequestData(url: APIProvider, type: HttpRequestType, parameters: ServiceParameters?) async -> ServiceRequestData
    func getActualToken() async -> Token
    func updateToken(_ token: Token) async
    func performRequest<T: Decodable>(data: ServiceRequestData) async throws -> T
}

class CoraServiceOperation: CoraServiceOperationing {
    
    // MARK: - Properties
    
    private var headerData: CachedHeaderActor
    private let serviceHelper = ServiceBuilderHelper()
    
    // MARK: - Initialize
    
    init(headerData: CachedHeaderActor = CachedHeaderActor()) {
        self.headerData = headerData
    }
    
    // MARK: - Public Methods
    
    func buildRequestData(url: APIProvider, type: HttpRequestType, parameters: ServiceParameters?) async -> ServiceRequestData {
        ServiceRequestData(
            url: serviceHelper.setFormattedAPI(url),
            httpMethod: type,
            header: await headerData.getHeader(),
            parameters: parameters
        )
    }
    
    func getActualToken() async -> Token {
        return await headerData.data
    }
    
    func updateToken(_ token: Token) async {
        await headerData.updateHeaderToken(token)
    }
    
    func performRequest<T: Decodable>(data: ServiceRequestData) async throws -> T {
        guard let request = try? ServiceBuilderHelper.buildRequest(data) else { throw BaseError.invalidRequest }
        let (data, responseInfo) = try await URLSession.shared.data(for: request)
        try ServiceBuilderHelper.verifyResponseCode(responseInfo)
        return try ServiceBuilderHelper.decodeObject(data)
    }
}
