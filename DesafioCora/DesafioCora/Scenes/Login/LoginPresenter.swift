import UIKit

protocol LoginPresenting {
    var viewController: LoginDisplay? { get set }
    
    func didLoginWith(_ message: String)
    func prepareForLoading()
    func somenthingWrongDidHappen(_ message: String)
}

class LoginPresenter: LoginPresenting {
    
    private let coordinator: LoginCoordinating
    weak var viewController: LoginDisplay?
    
    init(_ coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
    
    func didLoginWith(_ message: String) {
        viewController?.enableTextFields()
        viewController?.stopButtonLoading()
        coordinator.execute(.home(message))
    }
    
    func prepareForLoading() {
        viewController?.disableTextFields()
        viewController?.startButtonLoading()
    }
    
    func somenthingWrongDidHappen(_ message: String) {
        viewController?.enableTextFields()
        viewController?.stopButtonLoading()
        viewController?.errorMessage(message)
    }
}
