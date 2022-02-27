//
//  ServiceError.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

enum ServiceError: Error, Equatable {
    static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.requestError(let lhsError), .requestError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return lhs.localizedDescription == rhs.localizedDescription
        }
    }
    
    case noResponseData
    case invalidURL
    case decodingError
    case requestError(Error)
    case unknowError
}
