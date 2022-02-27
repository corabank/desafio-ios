//
//  ServiceError.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

enum ServiceError: Error, Equatable {
    static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.requestError(let lhsError), .requestError(let rhsError)):
            return lhsError.code == rhsError.code
        default:
            return lhs.localizedDescription == rhs.localizedDescription
        }
    }
    
    case noResponseData
    case invalidURL
    case decodingError
    case requestError(ServiceErrorData)
    case unknowError
    case networkError(Error?)
}

struct ServiceErrorData: Decodable {
    let code: Int?
    let message: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case title
    }
    
    init(code: Int, title: String, message: String) {
        self.code = code
        self.title = title
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code) ?? -1
        self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? "Não conseguimos recuperar os dados."
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Algo deu errado!"
    }
}
