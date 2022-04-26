import UIKit

public final class LoginCoordinator: LoginCoordinatorProtocol {
    
    private lazy var navigation: UINavigationController? = nil
    
    private let loginViewModel: LoginViewModelProtocol & LoginViewDelegate = LoginViewModel()
    private let loginView: LoginViewProtocol = LoginView()
    
    public init() {}
    
    public func set(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func start() {
        loginViewModel.set(view: loginView)
        loginView.set(delegate: loginViewModel)
        navigation?.pushViewController(loginView, animated: true)
    }
    
    public func login() {
        // todo
    }
}
