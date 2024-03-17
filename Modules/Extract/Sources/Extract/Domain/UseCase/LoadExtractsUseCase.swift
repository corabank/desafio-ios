//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation
import Core
import Network

//MARK: - protocol
protocol LoadExtractsUseCase {
    func run(completionHandler: @escaping (Result<ExtractList, NetworkError>) -> Void)
}

//MARK: - default implementation

final class DefaultLoadExtractsUseCase: LoadExtractsUseCase {
    private let repository: ExtractRepositoryProtocol
    
    init(repository: ExtractRepositoryProtocol) {
        self.repository = repository
    }
    
    func run(completionHandler: @escaping (Result<ExtractList, NetworkError>) -> Void) {
        repository.executeLoad(completionHandler: completionHandler)
    }
}
