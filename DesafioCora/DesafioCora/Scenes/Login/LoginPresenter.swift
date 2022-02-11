import UIKit

protocol LoginPresenting {
    var viewController: LoginDisplay? { get set }
}

class LoginPresenter: LoginPresenting {
    
    private let coordinator: LoginCoordinating
    weak var viewController: LoginDisplay?
    
    init(_ coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
}
