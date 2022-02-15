//
//  AnalyticsEventing.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation

protocol AnalyticsEventing {
    var name: String { get }
    var context: String { get }
    var properties: [String: String] { get }
}
