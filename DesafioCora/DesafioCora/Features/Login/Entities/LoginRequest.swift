//
//  LoginRequst.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

struct LoginRequest: ServiceRequest {
    let username: String
    let password: String

    var path: String = "/login"
    var method: HttpMethod = .post
    var params: [String : Any]? {
        return [
            "user": username,
            "password": password
        ]
    }
}
