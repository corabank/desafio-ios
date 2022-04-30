import UIKit
import XCTest
@testable import Login

final class LoginViewMock: UIViewController, LoginViewProtocol {
    
    var delegate: LoginViewDelegate?
    
    func set(delegate: LoginViewDelegate) {
        self.delegate = delegate
    }
}
