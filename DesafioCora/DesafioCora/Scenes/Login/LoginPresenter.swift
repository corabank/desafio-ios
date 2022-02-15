import UIKit

protocol LoginPresenting {
    var viewController: LoginDisplay? { get set }
    
    func didLoginWith(_ message: String)
    func somenthingWrongDidHappen(_ message: String)
}

class LoginPresenter: LoginPresenting {
    
    private let coordinator: LoginCoordinating
    weak var viewController: LoginDisplay?
    
    init(_ coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
    
    func didLoginWith(_ message: String) {
        coordinator.execute(.home(message))
    }
    
    func somenthingWrongDidHappen(_ message: String) {
        viewController?.enableTextFields()
        viewController?.stopButtonLoading()
        viewController?.errorMessage(message)
    }
}
