import UIKit
import XCTest
@testable import Login

final class PassFormCoordinatorMock: PassFormCoordinatorProtocol {
    
    var backWasTapped = false
    var started = false
    var gotToStatementWasTapped = false
    
    func set(navigation: UINavigationController?) {}
    
    func back() {
        backWasTapped = true
    }
    
    func start() {
        started = true
    }
    
    func goToStatement() {
        gotToStatementWasTapped = true
    }
}
