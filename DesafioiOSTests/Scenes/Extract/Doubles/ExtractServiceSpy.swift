//
//  ExtractServiceSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ExtractServiceDummy = ExtractServiceSpy

final class ExtractServiceSpy: ExtractServicing {
    
    private(set) var fetchCalled = false
    func fetch(completion: (Result<ExtractModel, ServiceError>) -> Void) {
        fetchCalled = true

        guard let data = CoraJsonManager(fileName: "extract-transactions").getData() else {
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
