import Foundation
@testable import DesafioCora

class AnalyticsSpy: AnalyticsProtocol {
        
    var logEventCallsCount: Int = 0
    var logEventInvocations: [AnalyticsEventing] = []
    
    func logEvent(_ event: AnalyticsEventing) {
        logEventCallsCount += 1
        logEventInvocations.append(event)
    }
}
