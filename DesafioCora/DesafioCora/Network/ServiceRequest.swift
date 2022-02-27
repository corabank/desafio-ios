//
//  ServiceRequest.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation


protocol ServiceRequest {
    var baseUrl: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var params: [String: Any]? { get }
    var headers: [String: String] { get }
}

extension ServiceRequest {
    var method: HttpMethod {
        return .get
    }
    
    var baseUrl: String {
        return "https://corabank.com/api"
    }
    
    var headers: [String: String] {
        return [:]
    }
}
