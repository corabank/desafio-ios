import UIKit
import XCTest
@testable import Statement

final class StatementDetailCoordinatorMock: StatementDetailCoordinatorProtocol {
    var backWasCalled = false
    var started = false
    
    func set(navigation: UINavigationController?) {}
    
    func start(statement: StatementItem, owner: Person) {
        started = true
    }
    
    func back() {
        backWasCalled = true
    }
}
