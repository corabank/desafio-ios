import Foundation

final class LoginViewModel {
    private var view: LoginViewProtocol?
    
    init() {}
}

extension LoginViewModel: LoginViewModelProtocol {
    func set(view: LoginViewProtocol) {
        self.view = view
    }
}

extension LoginViewModel: LoginViewDelegate {
    
}
