import UIKit
import XCTest
@testable import Statement

final class StatementViewMock: UIViewController, StatementViewProtocol {
    var delegate: StatementViewDelegate?
    
    func set(delegate: StatementViewDelegate) {
        self.delegate = delegate
    }
}
