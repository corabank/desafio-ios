//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import UIKit
import Core

struct ExtractItem: Codable {
    enum ExtractEntry: String, Codable {
        case debit = "DEBIT"
        case credit = "CREDIT"
        case none
    }
    
    enum ExtractStatus: String, Codable {
        case completed = "COMPLETED"
        case none
    }
    
    let id: String
    let description: String
    let label: String
    let amount: Int
    let name: String
    let dateEvent: String
    let entry: ExtractEntry
    let status: ExtractStatus
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        label = try container.decodeIfPresent(String.self, forKey: .label) ?? ""
        amount = try container.decodeIfPresent(Int.self, forKey: .amount) ?? 0
        dateEvent = try container.decodeIfPresent(String.self, forKey: .dateEvent) ?? ""
        entry = try container.decodeIfPresent(ExtractEntry.self, forKey: .entry) ?? .none
        status = try container.decodeIfPresent(ExtractStatus.self, forKey: .status) ?? .none
    }
    
    var textColor: UIColor {
        return (label.localizedCaseInsensitiveContains("recebida") || label.localizedCaseInsensitiveContains("recebido")) ? AppColors.receivedTransferColor : AppColors.textSecondaryColor
    }
    
    var leftIcon: UIImage {
        return (label.localizedCaseInsensitiveContains("recebida") || label.localizedCaseInsensitiveContains("recebido")) ? Images.Extract.arrowDownIn : Images.Extract.arrowUpOut
    }
}
