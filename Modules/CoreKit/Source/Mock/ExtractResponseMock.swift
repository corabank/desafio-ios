//
//  ExtractResponseMock.swift
//  DesignKit
//
//  Created by Erik Santos on 17/03/24.
//

import Foundation

extension ExtractResponse {
    public enum Mock {
        
        public static let extractDetails = ExtractDetailsResponse(description: "Mock Description",
                                                                  label: "Mock Label",
                                                                  amount: 100.0,
                                                                  counterPartyName: "Mock Counterparty",
                                                                  id: "123456789",
                                                                  dateEvent: "2024-03-24",
                                                                  recipient: ExtractBankInfo(bankName: "Banck Recipiente",
                                                                                             bankNumber: "123",
                                                                                             documentNumber: "12345678900",
                                                                                             documentType: "CPF",
                                                                                             accountNumberDigit: "1",
                                                                                             agencyNumberDigit: "2",
                                                                                             agencyNumber: "4567",
                                                                                             name: "Mock Name",
                                                                                             accountNumber: "123456"),
                                                                  sender: ExtractBankInfo(bankName: "Bank Sender",
                                                                                          bankNumber: "123",
                                                                                          documentNumber: "12345678900",
                                                                                          documentType: "CPF",
                                                                                          accountNumberDigit: "1",
                                                                                          agencyNumberDigit: "2",
                                                                                          agencyNumber: "4567",
                                                                                          name: "Mock Name",
                                                                                          accountNumber: "123456"),
                                                                  status: "Mock Status")
        
        public static let extractItems: [ExtractItemResponse] = [
            ExtractItemResponse(id: "123456", description: "Compra de produtos eletrônicos", label: "Compra aprovada", entry: "DEBIT", amount: 150000, name: "João da Silva", dateEvent: "2024-02-01T08:15:17Z", status: "COMPLETED"),
            ExtractItemResponse(id: "789012", description: "Pagamento de conta de luz", label: "Conta paga", entry: "DEBIT", amount: 8500, name: "Maria Oliveira", dateEvent: "2024-02-02T10:30:45Z", status: "COMPLETED"),
            ExtractItemResponse(id: "345678", description: "Transferência para conta poupança", label: "Transferência efetuada", entry: "DEBIT", amount: 20000, name: "Pedro Souza", dateEvent: "2024-02-03T14:20:00Z", status: "COMPLETED"),
            ExtractItemResponse(id: "901234", description: "Depósito em conta corrente", label: "Depósito efetuado", entry: "CREDIT", amount: 50000, name: "Ana Santos", dateEvent: "2024-02-04T16:45:30Z", status: "COMPLETED"),
            ExtractItemResponse(id: "567890", description: "Compra de roupas", label: "Compra aprovada", entry: "DEBIT", amount: 75000, name: "Carlos Oliveira", dateEvent: "2024-02-05T20:10:15Z", status: "COMPLETED")
        ]
        
        public static let value = ExtractResponse(results: [
            ExtractResultResponse(items: extractItems, date: "2024-02-01"),
            ExtractResultResponse(items: extractItems, date: "2024-02-02"),
            ExtractResultResponse(items: extractItems, date: "2024-02-03"),
            ExtractResultResponse(items: extractItems, date: "2024-02-04"),
            ExtractResultResponse(items: extractItems, date: "2024-02-05")
        ], itemsTotal: 3)
    }
}
