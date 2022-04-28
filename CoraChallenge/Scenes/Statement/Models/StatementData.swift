//
//  StatementData.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/27/22.
//

import Foundation

struct StatementData: Codable {
    var data: [StatementModel]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try values.decodeIfPresent([StatementModel].self, forKey: .data)
    }
}
