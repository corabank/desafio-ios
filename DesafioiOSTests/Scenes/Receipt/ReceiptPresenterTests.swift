//
//  ReceiptPresenterTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class ReceiptPresenterTests: XCTestCase {
    
    let coodinatorSpy = ReceiptCoordinatorSpy()
    let viewControllerSpy = ReceiptViewControllerSpy()
    lazy var sut = ReceiptPresenter(coordinator: coodinatorSpy)
    
    override func setUp() {
        super.setUp()
        sut.viewController = viewControllerSpy
    }
    
    func test_presentReceipt() {
        sut.presentReceipt()
        XCTAssertTrue(viewControllerSpy.displayReceiptCalled)
    }
    
    func test_presentError() {
        sut.presentError()
        XCTAssertTrue(coodinatorSpy.showErrorCalled)
    }
}
