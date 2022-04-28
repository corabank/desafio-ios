//
//  StatementModel.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

struct StatementModel: Codable {
    var info: [StatementModelData]?
    var date: String?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        info = try values.decodeIfPresent([StatementModelData].self, forKey: .info)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }
}
