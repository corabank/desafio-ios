//
//  ExtractDetailsResponse.swift
//  NetwokKit
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

public enum DocumentType: String {
    case cpf = "CPF"
    case cnpj = "CNPJ"
}

public struct ExtractDetailsResponse: Decodable {
    public let description: String
    public let label: String
    public let amount: CGFloat
    public let counterPartyName: String
    public let id: String
    public let dateEvent: String
    public let recipient: ExtractBankInfo
    public let sender: ExtractBankInfo
    public let status: String
}

public struct ExtractBankInfo: Decodable {
    public let bankName: String
    public let bankNumber: String
    public let documentNumber: String
    public let documentType: String
    public let accountNumberDigit: String
    public let agencyNumberDigit: String
    public let agencyNumber: String
    public let name: String
    public let accountNumber: String
}
