//
//  ExtractCoordinatorSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ExtractCoordinatorDummy = ExtractCoordinatorSpy

final class ExtractCoordinatorSpy: ExtractCoordinating {
    private(set) var showReceiptCalled = false
    func showReceipt() {
        showReceiptCalled = true
    }
}
