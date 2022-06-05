//
//  IntroInteractorTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class IntroInteractorTests: XCTestCase {
    func testOpenLogin_ShouldCallsPresentLogin() {
        let (sut, presenterSpy) = makeSut()

        sut.openLogin()

        XCTAssertEqual(presenterSpy.receivedMessages, [.presentLogin])
    }
}

extension IntroInteractorTests {
    func makeSut() -> (IntroInteractor, IntroPresenterSpy) {
        let presenterSpy = IntroPresenterSpy()
        let sut = IntroInteractor(presenter: presenterSpy)

        return (sut, presenterSpy)
    }
}
