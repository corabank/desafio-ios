//
//  Encodable+Extension.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation
import CoreKit

extension Encodable {
    
    func convert(to type: ServiceParametersType) throws -> ServiceParameters {
        
        do {
            let data = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: AnyObject]
            
            switch type {
            case .body:
                return ServiceParameters(bodyParameters: json, queryParameters: nil)
            case .query:
                let parameters: [String: String]? = json?.compactMapValues {"\($0)"}
                return ServiceParameters(bodyParameters: nil, queryParameters: parameters)
            }
        } catch {
            throw BaseError.convertParameterError
        }
    }
}
