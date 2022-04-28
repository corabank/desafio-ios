//
//  StatementRepository.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

class StatementRepository {
    
    static let jsonName = "CoraJsonVIII"
    
    func loadDataFromJason(fileName: String) -> [StatementModel]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(StatementData.self, from: data)
                return jsonData.data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
