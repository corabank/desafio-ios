//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import Foundation
import Core
import Network

public final class DefaultLoginRepository: LoginRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    public func executeLogin(with data: LoginData, completionHandler: @escaping ((Result<TokenRevalidationResponse, NetworkError>) -> Void)) {
        do {
            try networkService.request(TokenRevalidationResponse.self, router: AuthRoute.loginUser(data: data.asDictionary ?? [:]), completionHandler: completionHandler)
        } catch {
            completionHandler(.failure(.generic(error: error)))
        }
    }
}
