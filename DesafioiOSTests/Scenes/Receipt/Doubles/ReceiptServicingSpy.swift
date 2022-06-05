//
//  ReceiptServicingSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ReceiptServicingDummy = ReceiptServicingSpy

final class ReceiptServicingSpy: ReceiptServicing {
    
    private(set) var fetchCalled = false
    func fetch(completion: (Result<ReceiptModel, ServiceError>) -> Void) {
        fetchCalled = true

        guard let data = CoraJsonManager(fileName: "receipt-transaction").getData() else {
            completion(.failure(.notFound))
            return
        }
        let decoder = JSONDecoder()
        guard let model = try? decoder.decode(ReceiptModel.self, from: data) else {
            completion(.failure(.parse))
            return
        }
        completion(.success(model))
    }
    
}
