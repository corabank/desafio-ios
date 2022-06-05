//
//  ReceiptInteractorTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class ReceiptInteractorTests: XCTestCase {

    let serviceSpy = ReceiptServicingSpy()
    let presenterSpy = ReceiptPresenterSpy()
    lazy var sut = ReceiptInteractor(service: serviceSpy, presenter: presenterSpy)
    
    func test_fetch() {
        sut.fetch()
        XCTAssertTrue(presenterSpy.presentReceiptCalled)
    }
}
