import UIKit

enum LoginFactory {
    static func make(_ container: DependencyContainer = DependencyContainer()) -> UIViewController {
        let service: LoginServicing = LoginService(container)
        let coordinator: LoginCoordinating = LoginCoordinator()
        var presenter: LoginPresenting = LoginPresenter(coordinator)
        let interactor: LoginInteracting = LoginInteractor(presenter, service: service, container: container)
        let viewController: LoginViewController = LoginViewController(interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController
    }
}
