//
//  IntroPresenterTests.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import XCTest
@testable import DesafioiOS

final class CoordinatorSpy: IntroCoordinating {
    var viewController: UIViewController?
    
    enum Message: Equatable {
        case showLogin
    }
    
    private(set) var receivedMessages: [Message] = []
    
    func showLogin() {
        receivedMessages.append(.showLogin)
    }
}

class IntroPresenterTests: XCTestCase {
    func testPresentLogin_ShouldShowLoginScreen() {
        let (sut, coordinatorSpy) = makeSut()
        
        sut.presentLogin()
        
        XCTAssertEqual(coordinatorSpy.receivedMessages, [.showLogin])
    }
}

// MARK: - Helpers
extension IntroPresenterTests {
    func makeSut() -> (IntroPresenter, CoordinatorSpy) {
        let coordinatorSpy = CoordinatorSpy()
        let sut = IntroPresenter(coordinator: coordinatorSpy)        
        return (sut, coordinatorSpy)
    }
}
