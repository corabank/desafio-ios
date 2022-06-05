//
//  ReceiptInteractor.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import Foundation

protocol ReceiptInteracting: AnyObject {
    var model: ReceiptModel? { get }
    func fetch()
}

final class ReceiptInteractor: CoraInteractor<ReceiptPresenting>{
    let service: ReceiptServicing
    private(set) var model: ReceiptModel?
    
    init(service: ReceiptServicing, presenter: ReceiptPresenting ) {
        self.service = service
        super.init(presenter: presenter)
    }
}

extension ReceiptInteractor: ReceiptInteracting {
    func fetch() {
        service.fetch { result in
            switch result {
            case .success(let model):
                self.model = model
                presenter.presentReceipt()
            case .failure:
                presenter.presentError()
            }
        }
    }
}
