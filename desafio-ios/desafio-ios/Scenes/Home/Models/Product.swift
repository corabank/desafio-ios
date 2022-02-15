//
//  Products.swift
//  desafio-ios
//
//  Created by Barbara Barone on 12/02/22.
//

import Foundation

struct Product: Codable, Equatable {
    let products: [ProductItem]
}

struct ProductItem: Codable, Equatable {
    let value: Double
    let description: String
    let date: String
}
