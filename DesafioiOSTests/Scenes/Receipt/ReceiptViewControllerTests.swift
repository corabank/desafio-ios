//
//  ReceiptViewControllerTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 04/06/22.
//

import XCTest
import SnapshotTesting
@testable import DesafioiOS

final class ReceiptViewControllerTests: XCTestCase {
    
    let interactorSpy = ReceiptInteractorSpy()
    lazy var sut = ReceiptViewController(interactor: interactorSpy)
    
    func test_snapshot_view() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX, precision: 0.9))
    }
}
