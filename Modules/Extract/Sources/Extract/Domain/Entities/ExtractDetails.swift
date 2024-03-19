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

//MARK: - mock

extension ExtractDetails {
    static func getMock() -> ExtractDetails {
        let data = """
        {
          "description": "Pagamento por serviços prestados",
          "label": "Pagamento recebido",
          "amount": 150000,
          "counterPartyName": "Empresa ABC LTDA",
          "id": "id-mock-teste",
          "dateEvent": "2024-02-05T14:30:45Z",
          "recipient": {
            "bankName": "Banco XYZ",
            "bankNumber": "001",
            "documentNumber": "11223344000155",
            "documentType": "CNPJ",
            "accountNumberDigit": "9",
            "agencyNumberDigit": "7",
            "agencyNumber": "1234",
            "name": "Empresa ABC LTDA",
            "accountNumber": "987654"
          },
          "sender": {
            "bankName": "Banco ABC",
            "bankNumber": "002",
            "documentNumber": "99887766000112",
            "documentType": "CNPJ",
            "accountNumberDigit": "3",
            "agencyNumberDigit": "1",
            "agencyNumber": "5678",
            "name": "Empresa XYZ LTDA",
            "accountNumber": "543210"
          },
          "status": "COMPLETED"
        }
        """.data(using: .utf8)!
        
        return try! JSONDecoder().decode(ExtractDetails.self, from: data)
    }
}
