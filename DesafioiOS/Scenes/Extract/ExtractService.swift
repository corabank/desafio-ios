//
//  ExtractService.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

import Foundation

protocol ExtractServicing: AnyObject {
    func fetch(completion: (Result<ExtractModel, ServiceError>) -> Void)
}

final class ExtractService: ExtractServicing {
    
    let jsonManager: CoraJsonManagerProtocol
    
    init(jsonManager: CoraJsonManagerProtocol) {
        self.jsonManager = jsonManager
    }
    
    func fetch(completion: (Result<ExtractModel, ServiceError>) -> Void) {
        guard let data = jsonManager.getData() else {
            completion(.failure(.notFound))
            return
        }
        let decoder = JSONDecoder()
        guard let model = try? decoder.decode(ExtractModel.self, from: data) else {
            completion(.failure(.parse))
            return
        }
        completion(.success(model))
    }
}
