import UIKit

public final class LoginCoordinator {
    
    private var navigation: UINavigationController?
    
    public init() {}
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    public func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    public func start() {
        let loginViewModel: LoginViewModelProtocol & LoginViewDelegate = LoginViewModel()
        let loginView: LoginViewProtocol = LoginView()

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
