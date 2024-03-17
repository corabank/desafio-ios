//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation
import Network
import Core

enum ExtractListRoute: Router {
    case fetchData
    
    private var authToken: String {
        return UserDefaults.standard.string(forKey: Constants.accessTokenUserDefaultKey) ?? ""
    }

    var baseUri: String { NetworkConstants.baseAPIUri }
    var endpoint: String { "list" }
    var method: Network.RequestMethod { .get }
    
    var headers: Network.RequestHeader {
        NetworkConstants.defaultRequestHeaders.merging([Constants.tokenHeaderField: authToken], uniquingKeysWith: { $1 })
    }
    
    var queryItems: Network.RequestHeader { [:] }
    var parameters: [String : Any]? { nil }
}
