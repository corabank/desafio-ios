//
//  CoraTestTests.swift
//  CoraTestTests
//
//  Created by Sandor Ferreira on 24/07/21.
//

import XCTest
@testable import CoraTest

class CoraTestTests: XCTestCase {
    private let service: LoginServicing = LoginServiceMock()
    private let coordinator = LoginCoordinatorMock()
    
    private var sut: LoginViewModeling!
    
    override func setUp() {
        sut = LoginViewModel(service: service, coordinator: coordinator)
    }
    
    func testLogin_ShouldCallHomeScreen_WhenLoginSuccessfull() {
        let username = "Sandor"
        let pwd = "123"
        
        sut.login(with: username, and: pwd)
        XCTAssertEqual(coordinator.didGoToHomeScreen, 1)
    }
}
