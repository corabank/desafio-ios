import UIKit

enum LoginFactory {
    static func make() -> UIViewController {
        let service: LoginServicing = LoginService()
        let coordinator: LoginCoordinating = LoginCoordinator()
        var presenter: LoginPresenting = LoginPresenter(coordinator)
        let interactor: LoginInteracting = LoginInteractor(presenter, service: service)
        let viewController: LoginViewController = LoginViewController(interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController
    }
}
