import Foundation

final class LoginViewModel {
    private weak var view: LoginViewProtocol?
    private var coordinator: LoginCoordinatorProtocol?
    
    init() {}
}

extension LoginViewModel: LoginViewModelProtocol {
    func set(view: LoginViewProtocol) {
        self.view = view
    }
    
    func set(coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension LoginViewModel: LoginViewDelegate {
    func login() {
        coordinator?.login()
    }
    
    func register() {
        coordinator?.register()
    }
}
