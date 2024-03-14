//
//  AuthRoute.swift
//
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation
import Core

enum AuthRoute: Router {
    case requestNewToken(oldToken: String)
    
    var baseUri: String { NetworkConstants.baseAPIUri }
    
    var endpoint: String { "auth" }
    
    var method: RequestMethod { .post }
    
    var headers: RequestHeader { NetworkConstants.defaultRequestHeaders }
    
    var queryItems: RequestHeader { [:] }
    
    var parameters: Encodable? {
        switch self {
        case .requestNewToken(let oldToken):
            return [Constants.tokenKey: oldToken]
        }
    }
}
