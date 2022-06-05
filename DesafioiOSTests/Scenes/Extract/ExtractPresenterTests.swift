//
//  ExtractPresenterTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class ExtractPresenterTests: XCTestCase {
    
    let coodinatorSpy = ExtractCoordinatorSpy()
    let viewControllerSpy = ExtractViewControllerSpy()
    lazy var sut = ExtractPresenter(coordinator: coodinatorSpy)

    override func setUp() {
        super.setUp()
        sut.viewController = viewControllerSpy
    }
    
    func test_presentExtract() {
        sut.presentExtract()
        XCTAssertTrue(viewControllerSpy.displayExtractCalled)
    }
    
    func test_presentReceipt() {
        sut.presentReceipt()
        XCTAssertTrue(coodinatorSpy.showReceiptCalled)
    }
}
