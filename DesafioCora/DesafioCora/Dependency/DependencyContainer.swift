//
//  DependencyContainer.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation

typealias Dependencies =
    HasMainThread &
    HasAnalytics

class DependencyContainer: Dependencies {
    var mainThread: DispatchQueue = DispatchQueue.main
    var analytics: AnalyticsProtocol = Analytics()
}
