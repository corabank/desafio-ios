//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import UIKit
import Core

//MARK: - Entry

enum ExtractEntry: String, Codable {
    case debit = "DEBIT"
    case credit = "CREDIT"
    case none
}

struct DefaultExtractEntryStrategy: DefaultCodableStrategy {
    static var defaultValue: ExtractEntry { return .none }
}

typealias DefaultExtractEntry = DefaultCodable<DefaultExtractEntryStrategy>

//MARK: - Status

enum ExtractStatus: String, Codable {
    case completed = "COMPLETED"
    case none
}

struct DefaultExtractStatusStrategy: DefaultCodableStrategy {
    static var defaultValue: ExtractStatus { return .none }
}

typealias DefaultExtractStatus = DefaultCodable<DefaultExtractStatusStrategy>

//MARK: - item

struct ExtractItem: Codable {
    @DefaultString var id: String
    @DefaultString var description: String
    @DefaultString var label: String
    @DefaultInt var amount: Int
    @DefaultString var name: String
    @DefaultString var dateEvent: String
    @DefaultExtractEntry var entry: ExtractEntry
    @DefaultExtractStatus var status: ExtractStatus
    
    var textColor: UIColor {
        return (label.localizedCaseInsensitiveContains("recebida") || label.localizedCaseInsensitiveContains("recebido")) ? AppColors.receivedTransferColor : AppColors.textSecondaryColor
    }
    
    var leftIcon: UIImage {
        return (label.localizedCaseInsensitiveContains("recebida") || label.localizedCaseInsensitiveContains("recebido")) ? Images.Extract.arrowDownIn : Images.Extract.arrowUpOut
    }
}
