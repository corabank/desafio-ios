import UIKit
import XCTest
@testable import Login

final class CPFFormCoordinatorMock: CPFFormCoordinatorProtocol {
    
    var backWasTapped = false
    var started = false
    var loginWasTapped = false
    
    func set(navigation: UINavigationController?) {}
    
    func back() {
        backWasTapped = true
    }
    
    func start() {
        started = true
    }
    
    func login() {
        loginWasTapped = true
    }
}
