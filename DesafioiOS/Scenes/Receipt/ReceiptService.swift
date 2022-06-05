//
//  ReceiptService.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

import Foundation

protocol ReceiptServicing: AnyObject {
    func fetch(completion: (Result<ReceiptModel, ServiceError>) -> Void)
}

final class ReceiptService: ReceiptServicing {
    func fetch(completion: (Result<ReceiptModel, ServiceError>) -> Void) {
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
