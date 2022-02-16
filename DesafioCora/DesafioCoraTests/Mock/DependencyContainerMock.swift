import Foundation
@testable import DesafioCora

class DependencyContainerMock: Dependencies {
    var mainThread: DispatchQueue = DispatchQueue.global()
    var analytics: AnalyticsProtocol = AnalyticsSpy()
}
