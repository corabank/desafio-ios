//
//  LoginRepositoryProtocol.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

//sourcery: AutoMockable
protocol LoginRepositoryProtocol {
    func login(email: String, password: String, completionHandler: @escaping (Result<User, Error>) -> Void)
}
