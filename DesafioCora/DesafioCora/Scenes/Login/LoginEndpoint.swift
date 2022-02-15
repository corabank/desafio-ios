//
//  LoginEndpoint.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation

enum LoginEndpoint: EndpointProtocol {
    case login(_ viewModel: LoginModel)
    
    var path: String {
        "/login"
    }
    
    var params: [String : String] {
        switch self {
        case .login(let viewModel):
            return [
                Keys.username: viewModel.username,
                Keys.password: viewModel.password
            ]
        }
    }
}

private extension LoginEndpoint {
    enum Keys {
        static var username = "username"
        static var password = "password"
    }
}
