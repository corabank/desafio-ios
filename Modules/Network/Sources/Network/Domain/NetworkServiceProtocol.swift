//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation

public protocol NetworkServiceProtocol: AnyObject {
    var urlSession: URLSession { get }
    func request<T: Decodable>(_ type: T.Type, router: Router, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) throws
    func request<T: Decodable>(_ type: T.Type, request: URLRequest, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) throws
}
