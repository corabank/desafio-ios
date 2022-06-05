//
//  ReceiptPresenterSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ReceiptPresenterDummy = ReceiptPresenterSpy

final class ReceiptPresenterSpy: ReceiptPresenting {
    var viewController: ReceiptDisplaying?

    private(set) var presentReceiptCalled = false
    func presentReceipt() {
        presentReceiptCalled = true
    }
    
    private(set) var presentErrorCalled = false
    func presentError() {
        presentErrorCalled = true
    }
}
