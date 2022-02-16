import Foundation

protocol AnalyticsEventing {
    var name: String { get }
    var context: String { get }
    var properties: [String: String] { get }
}

extension AnalyticsEventing {
    var properties: [String: String] {
        [:]
    }
}
