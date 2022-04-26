import UIKit

public final class LoginCoordinator {
    
    private var navigation: UINavigationController?
    
    private let loginViewModel: LoginViewModelProtocol & LoginViewDelegate = LoginViewModel()
    private let loginView: LoginViewProtocol = LoginView()
    
    public init() {}
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    public func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    public func start() {
        loginViewModel.set(view: loginView)
        loginViewModel.set(coordinator: self)
        loginView.set(delegate: loginViewModel)
        navigation?.pushViewController(loginView, animated: true)
    }
    
    public func login() {
        let loginCoordinator: CPFFormCoordinatorProtocol = CPFFormCoordinator()
        loginCoordinator.set(navigation: self.navigation)
        loginCoordinator.start()
    }
    
    public func register() {
        print("register view =>")
    }
}
