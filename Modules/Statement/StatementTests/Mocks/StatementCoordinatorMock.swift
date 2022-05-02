import UIKit
import XCTest
@testable import Statement

final class StatementCoordinatorMock: StatementCoordinatorProtocol {
    
    var backWasTapped = false
    var started = false
    var gotToStatementWasTapped = false
    var detailItem: StatementItem?
    
    func set(navigation: UINavigationController?) {}
    
    func start() {
        started = true
    }
    
    func back() {
        backWasTapped = true
    }
    
    func goToDetail(item: StatementItem) {
        detailItem = item
    }
}
