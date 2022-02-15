//
//  Analytics.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation

protocol AnalyticsProtocol: AnyObject {
    func logEvent(_ event: AnalyticsEventing)
}

class Analytics: AnalyticsProtocol {
    func logEvent(_ event: AnalyticsEventing) {
        print("### Event log ###")
        print("Name: \(event.name)")
        print("Name: \(event.context)")
        print("Name: \(event.properties)")
    }
}
