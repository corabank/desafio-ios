//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import Foundation
import Core
import Network

//MARK: - protocol

protocol LoadExtractDetailsUseCase {
    func run(withId id: String, completionHandler: @escaping (Result<ExtractDetails, NetworkError>) -> Void)
}

//MARK: - default implementation

final class DefaultLoadExtractDetailsUseCase: LoadExtractDetailsUseCase {
    private let repository: ExtractRepositoryProtocol
    
    init(repository: ExtractRepositoryProtocol) {
        self.repository = repository
    }
    
    func run(withId id: String, completionHandler: @escaping (Result<ExtractDetails, NetworkError>) -> Void) {
        repository.executeLoad(forId: id, completionHandler: completionHandler)
    }
}
