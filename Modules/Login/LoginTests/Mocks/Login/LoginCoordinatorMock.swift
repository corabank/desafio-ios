import UIKit
import XCTest
@testable import Login

final class LoginCoordinatorMock: LoginCoordinatorProtocol {
    
    var started = false
    var goToLogin = false
    var goToRegister = false
    
    func set(navigation: UINavigationController?) {}
    
    func start() {
        started = true
    }
    
    func login() {
        goToLogin = true
    }
    
    func register() {
        goToRegister = true
    }
}
