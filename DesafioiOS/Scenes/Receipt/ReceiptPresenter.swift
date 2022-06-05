//
//  ReceiptPresenter.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import Foundation

protocol ReceiptPresenting: AnyObject {
    var viewController: ReceiptDisplaying? {get set}
    func presentReceipt()
    func presentError()
}

final class ReceiptPresenter: CoraPresenter<ReceiptCoordinating> {
    weak var viewController: ReceiptDisplaying?
}

extension ReceiptPresenter: ReceiptPresenting {
    func presentReceipt() {
        viewController?.displayReceipt()
    }
    
    func presentError() {
        coordinator.showError()
    }
}
