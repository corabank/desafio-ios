//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation
import Network
import Core

enum ExtractRoute: Router {
    case fetchData
    case loadDetails(id: String)
    
    private var authToken: String {
        return UserDefaults.standard.string(forKey: Constants.accessTokenUserDefaultKey) ?? ""
    }

    var baseUri: String { NetworkConstants.baseAPIUri }
    
    var endpoint: String {
        switch self {
        case .fetchData:
            return "list"
        case .loadDetails(let id):
            return "details/\(id)"
        }
    }
    
    var method: Network.RequestMethod { .get }
    
    var headers: Network.RequestHeader {
        NetworkConstants.defaultRequestHeaders.merging([Constants.tokenHeaderField: authToken], uniquingKeysWith: { $1 })
    }
    
    var queryItems: Network.RequestHeader { [:] }
    
    var parameters: [String : Any]? { nil }
}
