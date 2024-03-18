//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import Foundation
import Core

struct ExtractDetails: Codable {
    @DefaultString var id: String
    @DefaultString var description: String
    @DefaultString var label: String
    @DefaultString var counterPartyName: String
    @DefaultString var dateEvent: String
    @DefaultInt var amount: Int
    @DefaultExtractStatus var status: ExtractStatus
    
    var recipient: BankDetails?
    var sender: BankDetails?
}

struct BankDetails: Codable {
    @DefaultString var bankName: String
    @DefaultString var bankNumber: String
    @DefaultString var documentNumber: String
    @DefaultString var documentType: String
    @DefaultString var accountNumberDigit: String
    @DefaultString var accountNumber: String
    @DefaultString var agencyNumberDigit: String
    @DefaultString var agencyNumber: String
    @DefaultString var name: String
}
