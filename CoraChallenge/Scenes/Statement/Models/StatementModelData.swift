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
    var date: String?
    var sender: SenderData?
    var receiver: ReceiverData?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case transactionType = "transactionType"
        case value = "value"
        case date = "date"
        case sender = "sender"
        case receiver = "receiver"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        transactionType = try values.decodeIfPresent(String.self, forKey: .transactionType)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        sender = try values.decodeIfPresent(SenderData.self, forKey: .sender)
        receiver = try values.decodeIfPresent(ReceiverData.self, forKey: .receiver)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
//    init(transactionType: String,
//         value: Double,
//         date: String,
//         sender: SenderData,
//         receiver: ReceiverData,
//         description: String) {
//        self.transactionType = transactionType
//        self.value = value
//        self.date = date
//        self.sender = sender
//        self.receiver = receiver
//        self.description = description
//    }
}
