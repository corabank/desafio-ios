//
//  ReceiptCoordinatorSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ReceiptCoordinatorDummy = ReceiptCoordinatorSpy

final class ReceiptCoordinatorSpy: ReceiptCoordinating {
    private(set) var showErrorCalled = false
    func showError() {
        showErrorCalled = true
    }
}
