import UIKit
import XCTest
@testable import Statement

final class StatementDetailViewMock: UIViewController, StatementDetailViewProtocol {
    
    var delegate: StatementDetailViewDelegate?
    
    var shareActionCalled = false
    var cancelActionCalled = false
    
    var statement: StatementItem? = nil
    var personTo: Person? = nil
    var personFrom: Person? = nil
    var navTitle = ""
    var mainTitle = ""
    
    func set(delegate: StatementDetailViewDelegate) {
        self.delegate = delegate
    }
    
    func shareAction() {
        shareActionCalled = true
    }
    
    func cancelAction() {
        cancelActionCalled = true
    }
    
    func setInto(statement: StatementItem, from: Person, to: Person, navigationTitle: String, title: String) {
        self.statement = statement
        self.personFrom = from
        self.personTo = to
        self.navTitle = navigationTitle
        self.mainTitle = title
    }
}
