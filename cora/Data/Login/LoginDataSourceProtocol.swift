//
//  LoginDataSourceProtocol.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

//sourcery: AutoMockable
protocol LoginDataSourceProtocol {
    func login(email: String, password: String, completionHandler: @escaping (Result<UserDTO, Error>) -> Void)
}
