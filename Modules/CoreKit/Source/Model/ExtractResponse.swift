//
//  ExtractResponse.swift
//  NetwokKit
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

public struct ExtractResponse: Decodable {
    public let results: [ExtractResultResponse]
    public let itemsTotal: Int
    
    public init(results: [ExtractResultResponse], itemsTotal: Int) {
        self.results = results
        self.itemsTotal = itemsTotal
    }
}

public struct ExtractResultResponse: Decodable {
    public let items: [ExtractItemResponse]
    public let date: String
    
    public init(items: [ExtractItemResponse], date: String) {
        self.items = items
        self.date = date
    }
}

public struct ExtractItemResponse: Decodable {
    public let id: String
    public let description: String
    public let label: String
    public let entry: String
    public let amount: CGFloat
    public let name: String
    public let dateEvent: String
    public let status: String
    
    public init(id: String, description: String, label: String, entry: String, amount: CGFloat, name: String, dateEvent: String, status: String) {
        self.id = id
        self.description = description
        self.label = label
        self.entry = entry
        self.amount = amount
        self.name = name
        self.dateEvent = dateEvent
        self.status = status
    }
}
