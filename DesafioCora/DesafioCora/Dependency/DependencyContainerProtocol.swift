//
//  DependencyContainerProtocol.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation

protocol HasMainThread: AnyObject {
    var mainThread: DispatchQueue { get }
}

protocol HasAnalytics: AnyObject {
    var analytics: AnalyticsProtocol { get }
}
