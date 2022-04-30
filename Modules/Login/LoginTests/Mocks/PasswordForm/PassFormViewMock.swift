import UIKit
import XCTest
import Components
@testable import Login

final class PassFormViewMock: UIViewController, PassFormViewProtocol {
    
    var delegate: PassFormViewDelegate?
    var buttonStatus: ButtonState? = nil
    
    func set(delegate: PassFormViewDelegate) {
        self.delegate = delegate
    }
    
    func changeButtonStatus(_ value: ButtonState) {
        buttonStatus = value
    }
}
