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
    let dispatchQueue: DispatchQueueType = DispatchQueue.main
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, ServiceError>) -> Void) {
        dispatchQueue.asyncAfter(DispatchTime.now() + 1, work: {
            if username.lowercased() == "lucas" && password == "123456" {
                completion(.success(LoginResponse(token: "abcdefGHIJKMN12345678", id: "1", name: "Lucas")))
            } else {
                completion(.failure(.requestError(ServiceErrorData(code: 401, title: "Dados inválidos", message: "Usuário ou senha inválidos"))))
            }
        })
    }
    
    func loadTransactions(completion: @escaping (Result<[TransactionModel], ServiceError>) -> Void) {
        dispatchQueue.asyncAfter(DispatchTime.now() + 1) {
            completion(.success(TransactionModel.sampleData()))
        }
    }
}
