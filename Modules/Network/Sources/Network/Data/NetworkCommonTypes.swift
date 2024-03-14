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
