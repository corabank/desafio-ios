//
//  InvoiceService.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 18/05/22.
//

import Foundation

protocol InvoiceServiceDelegate {
    func loadData() -> InvoiceModel
}

final class InvoiceService {
    @Published var invoiceData = InvoiceModel(invoiceResume: nil, mainTransactions: [], cards: [])
}

// MARK: - ExtractServicing
extension InvoiceService: InvoiceServiceDelegate {
    func loadData() -> InvoiceModel {
        if let fileLocation = Bundle.main.url(forResource: "invoice", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataFromJson = try jsonDecoder.decode(InvoiceModel.self, from: data)
                self.invoiceData = dataFromJson
                return invoiceData
            } catch {
                print(error)
            }
        }
        return InvoiceModel(invoiceResume: nil, mainTransactions: [], cards: [])
    }
}
