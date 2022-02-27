//
//  LoginResponse.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String
    let id: String
    let name: String
}
