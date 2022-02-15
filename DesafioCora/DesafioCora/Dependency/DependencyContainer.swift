import Foundation

typealias Dependencies =
    HasMainThread &
    HasAnalytics

class DependencyContainer: Dependencies {
    var mainThread: DispatchQueue = DispatchQueue.main
    var analytics: AnalyticsProtocol = Analytics()
}
