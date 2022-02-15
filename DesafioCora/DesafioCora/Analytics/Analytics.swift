import Foundation

protocol AnalyticsProtocol: AnyObject {
    func logEvent(_ event: AnalyticsEventing)
}

class Analytics: AnalyticsProtocol {
    func logEvent(_ event: AnalyticsEventing) {
        print("### Event log ###")
        print("Name: \(event.name)")
        print("Context: \(event.context)")
        print("Props: \(event.properties)")
    }
}
