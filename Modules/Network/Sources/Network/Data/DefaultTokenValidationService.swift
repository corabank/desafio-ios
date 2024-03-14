//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation
import Core

final class DefaultTokenValidationService: TokenValidationServiceProtocol {
    private let queue = OperationQueue()
    
    weak var networkService: NetworkServiceProtocol?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        queue.maxConcurrentOperationCount = 1
    }
    
    func requestTokenAndRetry<T: Decodable>(request: URLRequest, decodeToType type: T.Type, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) throws {
        let tokenBlock = BlockOperation { [weak self] in
            guard let self else { return }

            let oldToken = UserDefaults.standard.value(forKey: Constants.accessTokenUserDefaultKey) as? String
            
            try? networkService?.request(
                TokenRevalidationResponse.self,
                router: AuthRoute.requestNewToken(oldToken: oldToken ?? "")
            ) { [weak queue] result in
                switch result {
                case .success(let data):
                    UserDefaults.standard.set(data.token, forKey: Constants.accessTokenUserDefaultKey)
                case .failure(let failure):
                    completionHandler(.failure(failure))
                    queue?.cancelAllOperations() // dont execute the retry block
                }
            }
        }
        
        let retryBlock = BlockOperation { [weak self] in
            guard let self else { return }
            
            try? networkService?.request(
                type.self,
                request: request,
                completionHandler: completionHandler
            )
        }
        
        retryBlock.addDependency(tokenBlock)
        queue.addOperations([tokenBlock, retryBlock], waitUntilFinished: true)
    }
}
