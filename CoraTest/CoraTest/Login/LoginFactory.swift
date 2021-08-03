import Foundation

struct LoginFactory {
    static func make() -> LoginViewController {
        let service = LoginService()
        let coordinator = LoginCoordinator()
        let viewModel = LoginViewModel(service: service, coordinator: coordinator)
        let viewController = LoginViewController(viewModel: viewModel)
        
        return viewController
    }
}
