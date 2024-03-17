//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation

struct ExtractList: Codable {
    let results: [ExtractResult]
    let itemsTotal: Int
}

struct ExtractResult: Codable {
    let items: [ExtractItem]
    let date: String
}


//MARK: - mock

extension ExtractList {
    static var mock: ExtractList {
        let data = """
        {
          "results": [
            {
              "items": [
                {
                  "id": "abc123def456ghi789",
                  "description": "Compra de produtos eletrônicos",
                  "label": "Compra aprovada",
                  "entry": "DEBIT",
                  "amount": 150000,
                  "name": "João da Silva",
                  "dateEvent": "2024-02-01T08:15:17Z",
                  "status": "COMPLETED"
                }
              ],
              "date": "2024-02-01"
            }
          ],
          "itemsTotal": 1
        }
        """.data(using: .utf8)!
        
        let decoded = try! JSONDecoder().decode(ExtractList.self, from: data)
        return decoded
    }
}
