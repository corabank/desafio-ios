//
//  EndpointProtocol.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation

protocol EndpointProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var params: [String: String] { get }
}

extension EndpointProtocol {
    var baseUrl: String {
        "www.google.com"
    }
}
