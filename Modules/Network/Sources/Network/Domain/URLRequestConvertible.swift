//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation

/// Represents a type that can be converted to `URLRequest` type
public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

/// Possible error cases when converting to `URLRequest`
public enum URLRequestConvertibleError: Error {
    case routerConversionError
}
