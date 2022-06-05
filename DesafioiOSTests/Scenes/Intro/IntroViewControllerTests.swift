//
//  IntroViewControllerTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 04/06/22.
//

import XCTest
import SnapshotTesting
@testable import DesafioiOS

final class IntroViewControllerTests: XCTestCase {
    
    let interactorSpy = IntroInteractorSpy()
    lazy var sut = IntroViewController(interactor: interactorSpy)
    
    func test_snapshot_view() {
        if UIScreen.main.sizeType == .iPhone5 {
            assertSnapshot(matching: sut, as: .image(on: .iPhoneSe, precision: 0.9), testName: "iphoneSE")
        } else {
            assertSnapshot(matching: sut, as: .image(on: .iPhoneX, precision: 0.9), testName: "intoTest")
        }
    }
    
    func test_didTapButtonLogin() {
        sut.didTapButtonLogin()
        XCTAssertTrue(interactorSpy.openLoginCalled)
    }
}
