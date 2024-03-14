//
//  AuthRoute.swift
//
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation
import Core

public enum AuthRoute: Router {
    case requestNewToken(oldToken: String)
    case loginUser(data: Encodable)
    
    public var baseUri: String { NetworkConstants.baseAPIUri }
    
    public var endpoint: String { "auth" }
    
    public var method: RequestMethod { .post }
    
    public var headers: RequestHeader { NetworkConstants.defaultRequestHeaders }
    
    public var queryItems: RequestHeader { [:] }
    
    public var parameters: Encodable? {
        switch self {
        case .requestNewToken(let oldToken):
            return [Constants.tokenKey: oldToken]
        case.loginUser(let data):
            return data
        }
    }
}
