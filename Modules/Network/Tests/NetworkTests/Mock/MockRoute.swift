//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation
import Network

enum MockRoute: Router {
    case catSearch
    
    var baseUri: String { "https://api.thecatapi.com" }
    var endpoint: String { "v1/images/search" }
    var method: RequestMethod { .get }
    var headers: RequestHeader { ["Content-Type": "application/json"] }
    var queryItems: RequestHeader { [:]}
    var parameters: Encodable? { nil }  
}
