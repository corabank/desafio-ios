import Foundation

protocol HasMainThread: AnyObject {
    var mainThread: DispatchQueue { get }
}

protocol HasAnalytics: AnyObject {
    var analytics: AnalyticsProtocol { get }
}
