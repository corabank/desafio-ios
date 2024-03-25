//
//  ApiProvider.swift
//  CoreKit
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

public enum APIProvider {
    case auth
    case extractList
    case extractDetails(_ id: String)
    
    public var value: String {
        switch self {
        case .auth:
            return "challenge/auth"
        case .extractList:
            return "challenge/list"
        case let .extractDetails(id):
            return "challenge/details/\(id)"
        }
    }
}
