//
//  LoginCoordinatorMock.swift
//  CoraTestTests
//
//  Created by Sandor Ferreira on 28/07/21.
//

import Foundation
@testable import CoraTest

final class LoginCoordinatorMock: LoginCoordinating {
    private(set) var didGoToHomeScreen = 0
    
    func goToHomeScreen() {
        didGoToHomeScreen += 1
    }
}
