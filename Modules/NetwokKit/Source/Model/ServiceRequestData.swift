//
//  ServiceRequestData.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

typealias ServiceParameters = (bodyParameters: [String: Any]?, queryParameters: [String: String]?)

enum HttpRequestType: String {
    case get = "GET"
    case post = "POST"
}

enum ServiceParametersType {
    case body
    case query
}

struct ServiceRequestData {
    
    let url: String
    let httpMethod: HttpRequestType
    let header: [String: String]
    let parameters: ServiceParameters?
    
    init(url: String, httpMethod: HttpRequestType, header: [String : String] = [:], parameters: ServiceParameters?) {
        self.url = url
        self.httpMethod = httpMethod
        self.header = header
        self.parameters = parameters
    }
}
