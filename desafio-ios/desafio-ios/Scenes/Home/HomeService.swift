//
//  HomeService.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import Foundation

protocol HomeServicing {
    func readLocalFile(forName name: String) -> Data?
    func parse(jsonData: Data) -> Product?
}

final class HomeService: HomeServicing {
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,  ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func parse(jsonData: Data) -> Product? {
        do {
            let decodedData = try JSONDecoder().decode(Product.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
}
