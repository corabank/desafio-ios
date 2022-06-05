//
//  ExtractPresenterSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ExtractPresenterDummy = ExtractPresenterSpy

final class ExtractPresenterSpy: ExtractPresenting {
    var viewController: ExtractDisplaying?

    private(set) var presentExtractCalled = false
    func presentExtract() {
        presentExtractCalled = true
    }
    
    private(set) var presentErrorCalled = false
    func presentError() {
        presentErrorCalled = true
    }
    
    private(set) var presentReceiptCalled = false
    func presentReceipt() {
        presentReceiptCalled = true
    }
}
