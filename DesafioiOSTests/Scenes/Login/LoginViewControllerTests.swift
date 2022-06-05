//
//  LoginViewControllerTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 04/06/22.
//


import XCTest
import SnapshotTesting
@testable import DesafioiOS

final class LoginCPFViewControllerTests: XCTestCase {
    
    let interactorSpy = LoginInteractorDummy(screenType: .cpf)
    lazy var sut = LoginViewController(interactor: interactorSpy)
    
    func test_snapshot_view() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX, precision: 0.9))
    }
}

final class LoginPasswordViewControllerTests: XCTestCase {
    
    let interactorSpy = LoginInteractorDummy(screenType: .password)
    lazy var sut = LoginViewController(interactor: interactorSpy)
    
    func test_snapshot_view() {
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX, precision: 0.9))
    }
}
