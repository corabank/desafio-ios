//
//  ReceiverData.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

struct ReceiverData: Codable {
    var name: String?
    var documentNumber: String?
    var institutionName: String?
    var agencyNumber: String?
    var accountNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case documentNumber = "documentNumber"
        case institutionName = "institutionName"
        case agencyNumber = "agencyNumber"
        case accountNumber = "accountNumber"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name)
        documentNumber = try values.decodeIfPresent(String.self, forKey: .documentNumber)
        institutionName = try values.decodeIfPresent(String.self, forKey: .institutionName)
        agencyNumber = try values.decodeIfPresent(String.self, forKey: .agencyNumber)
        accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
    }
    
    
//    init(name: String,
//         documentNumber: String,
//         institutionName: String,
//         agencyNumber: String?,
//         accountNumber: String?) {
//        self.name = name
//        self.documentNumber = documentNumber
//        self.institutionName = institutionName
//        self.agencyNumber = agencyNumber
//        self.accountNumber = accountNumber
//    }
}
