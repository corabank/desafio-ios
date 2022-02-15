import Foundation

protocol EndpointProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var params: [String: String] { get }
    var body: Data? { get }
}

extension EndpointProtocol {
    var baseUrl: String {
        "www.google.com"
    }
    
    var params: [String: String] {
        [:]
    }
    
    var body: Data? {
        nil
    }
}
