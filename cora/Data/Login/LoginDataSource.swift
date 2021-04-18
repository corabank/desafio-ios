//
//  LoginDataSource.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

class LoginDataSource: LoginDataSourceProtocol {
    func login(email: String, password: String,
               completionHandler: @escaping (Result<UserDTO, Error>) -> Void) {
        // Connect to API
        // ...

        // Fake data
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if email == "lucas.fernandes.silveira@gmail.com" && password == "caveira2021" {
                let userDTO = UserDTO(id: UUID().uuidString,
                                      name: "Lucas Silveira",
                                      email: "lucas.fernandes.silveira@gmail.com")
                completionHandler(.success(userDTO))
            } else {
                completionHandler(.failure(URLError(.unknown)))
            }
        }
    }
}
