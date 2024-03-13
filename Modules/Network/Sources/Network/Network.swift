import Foundation

public typealias RequestHeader = [String: String]

/// Methods available when sending a request
public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

public enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionError
    case generic(error: Error?)
}

/// Represents a type that can be converted to `URLRequest` type
public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

/// Possible error cases when converting to `URLRequest`
public enum URLRequestConvertibleError: Error {
    case routerConversionError
}

