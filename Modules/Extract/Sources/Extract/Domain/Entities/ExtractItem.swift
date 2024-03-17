//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation

struct ExtractItem: Codable {
    let id: String
    let description: String?
    let label: String
    let entry: String
    let amount: Int
    let name: String
    let dateEvent: String
    let status: String
}
