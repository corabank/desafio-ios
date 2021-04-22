//
//  LoginRepository.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

class LoginRepository: LoginRepositoryProtocol {
    private let dataSource: LoginDataSourceProtocol

    init(dataSource: LoginDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func login(email: String, password: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
        self.dataSource.login(email: email, password: password) { result in
            do {
                let user = User(userDTO: try result.get())
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
