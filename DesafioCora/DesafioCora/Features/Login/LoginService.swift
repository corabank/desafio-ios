//
//  LoginService.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

protocol LoginServicing {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, ServiceError>) -> Void)
}

final class LoginService {
    let client: NetworkClient
    let dispatchQueue: DispatchQueueType
    
    init(client: NetworkClient = DefaultNetwoktClient(), dispatchOn: DispatchQueueType = DispatchQueue.main) {
        self.client = client
        self.dispatchQueue = dispatchOn
    }
}

extension LoginService: LoginServicing {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, ServiceError>) -> Void) {
        let request = LoginRequest(username: username, password: password)
        client.execute(request: request, responseType: LoginResponse.self) { [weak self] result in
            self?.dispatchQueue.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error as? ServiceError ?? ServiceError.unknowError))
                }
            }
        }
    }
}

// Mocked Service
final class MockedLoginService: LoginServicing {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, ServiceError>) -> Void) {
            if username.lowercased() == "lucas" && password == "123456" {
                completion(.success(LoginResponse(token: "abcdefGHIJKMN12345678", id: "1", name: "Lucas")))
            } else {
                completion(.failure(.requestError(ServiceErrorData(code: 401, title: "Dados inválidos", message: "Usuário ou senha inválidos"))))
            }
    }
}
