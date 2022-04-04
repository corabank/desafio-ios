//
//  Extract.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 19/03/22.
//

import Foundation

struct DayExtract: Codable {
    let day: String
    let total: Double
    let extracts: [Extract]
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case total = "total"
        case extracts = "extracts"
    }
}

struct Extract: Codable {
    var value: Double
    var typeTransfer: String
    var name: String
    var hour: String
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case typeTransfer = "type_transfer"
        case name = "name"
        case hour = "hour"
    }
}
