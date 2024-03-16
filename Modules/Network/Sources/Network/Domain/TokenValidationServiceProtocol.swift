//
//  TokenValidationServiceProtocol.swift
//
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation

public protocol TokenValidationServiceProtocol: AnyObject {
    func requestTokenAndRetry<T: Decodable>(request: URLRequest, decodeToType type: T.Type, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) throws
}

