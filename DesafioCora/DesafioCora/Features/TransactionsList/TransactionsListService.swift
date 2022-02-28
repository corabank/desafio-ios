//
//  TransactionsListService.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

protocol TransactionsListServicing {
    func loadTransactions(completion: @escaping (Result<[TransactionModel], ServiceError>) -> Void)
}

final class TransactionsListService {
    let client: NetworkClient
    let dispatchQueue: DispatchQueueType
    
    init(client: NetworkClient = DefaultNetwoktClient(), dispatchOn: DispatchQueueType = DispatchQueue.main) {
        self.client = client
        self.dispatchQueue = dispatchOn
    }
}

extension TransactionsListService: TransactionsListServicing {
    func loadTransactions(completion: @escaping (Result<[TransactionModel], ServiceError>) -> Void) {
        let request = TransactionsRequest()
        client.execute(request: request, responseType: [TransactionModel].self) { result in
            switch result {
            case .success(let transactions):
                completion(.success(transactions))
            case .failure(let error):
                completion(.failure(error as? ServiceError ?? ServiceError.unknowError))
            }
        }
    }
}


// Mocked Service
final class MockedTransactionsListService: TransactionsListServicing {
    func loadTransactions(completion: @escaping (Result<[TransactionModel], ServiceError>) -> Void) {
            completion(.success(TransactionModel.sampleData()))
    }
}
