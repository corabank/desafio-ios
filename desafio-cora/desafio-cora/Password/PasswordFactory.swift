import UIKit

enum PasswordFactory {
    static func make() -> UIViewController {
        let coordinator: PasswordCoordinating = PasswordCoordinator()
        let presenter: PasswordPresenting = PasswordPresenter(coordinator: coordinator)
        let interactor = PasswordInteractor(presenter: presenter)
        let viewController = PasswordViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
