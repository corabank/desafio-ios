//
//  StatementModelData.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

struct StatementModelData: Codable {
    var transactionType: String?
    var value: Double?
    var sender: SenderData?
    var receiver: ReceiverData?
    var description: String?
    var imageName: String?
    
    enum CodingKeys: String, CodingKey {
        case transactionType = "transactionType"
        case value = "value"
        case sender = "sender"
        case receiver = "receiver"
        case description = "description"
        case imageName = "imageName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        transactionType = try values.decodeIfPresent(String.self, forKey: .transactionType)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        sender = try values.decodeIfPresent(SenderData.self, forKey: .sender)
        receiver = try values.decodeIfPresent(ReceiverData.self, forKey: .receiver)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageName = try values.decodeIfPresent(String.self, forKey: .imageName)
    }
}
