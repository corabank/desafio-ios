//
//  ExtractCoordinatorTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class ExtractCoordinatorTests: XCTestCase {
    func test_Extract() {
        let (sut, navigationSpy) = makeSut()
        sut.showReceipt()
 
        XCTAssertTrue(navigationSpy.pushedViewController is ReceiptViewController)
        XCTAssertEqual(navigationSpy.pushViewControllerCallCount, 2)
    }
}

extension ExtractCoordinatorTests {
    func makeSut() -> (ExtractCoordinator, UINavigationControllerSpy) {
        let viwControllerSpy = UIViewControllerSpy()
        let navigationSpy = UINavigationControllerSpy(rootViewController: viwControllerSpy)
        let sut = ExtractCoordinator()
        sut.viewController = viwControllerSpy

        return (sut, navigationSpy)
    }
}
