//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import Foundation
import Core
import Network

//MARK: - protocol

public protocol LogUserUseCase {
    func run(requestData: LoginData, completion: @escaping (Result<TokenRevalidationResponse, NetworkError>) -> Void)
}

//MARK: - default implementation

public final class DefaultLogUserUseCase: LogUserUseCase {
    private let repository: LoginRepositoryProtocol
    
    public init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }
    
    public func run(requestData: LoginData, completion: @escaping (Result<TokenRevalidationResponse, NetworkError>) -> Void) {
        repository.executeLogin(with: requestData, completionHandler: completion)
    }
}
