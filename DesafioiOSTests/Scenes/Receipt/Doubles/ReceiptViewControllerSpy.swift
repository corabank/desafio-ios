//
//  ReceiptViewControllerSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ReceiptViewControllerDummy = ReceiptViewControllerSpy

final class ReceiptViewControllerSpy: ReceiptDisplaying {
    private(set) var displayReceiptCalled = false
    func displayReceipt() {
        displayReceiptCalled = true
    }
}
