//
//  Router.swift
//
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation
import Core

/**
 A type that can be used as a Router for the Network requests.
 
 Usage example:
 ````
enum ExampleRouter: Router {
    case routeOne, routeTwo

    var endpoint: String {
        switch self {
            case .routeOne:
            return "routeOne" // no need to use '/routeOne'
            case .routeTwo:
            return "routeTwo"
        }
     }
 
     var method: String {
         return .GET
      }
 
     var headers: String {
         return [:]
      }
    
    func asURLRequest() -> URLRequest {...}
}
 ````
 */
public protocol Router: URLRequestConvertible {
    var baseUri: String { get }
    var endpoint: String { get }
    var method: RequestMethod { get }
    var headers: RequestHeader { get }
    var queryItems: RequestHeader { get }
    var parameters: [String: Any]? { get }
}

public extension Router {
    /// Default implementation for the method. It automatically converts each field and generates a `URLRequest`. Can throw
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: "\(baseUri)/\(endpoint)")
        urlComponents?.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
        
        guard let url = urlComponents?.url else {
            throw URLRequestConvertibleError.routerConversionError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return request
    }
}
