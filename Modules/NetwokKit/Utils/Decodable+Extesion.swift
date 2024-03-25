//
//  Decodable+Extesion.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

extension Decodable {
    static func fromData(_ data: Data) throws -> Self {
        try JSONDecoder().decode(self, from: data)
    }
}
