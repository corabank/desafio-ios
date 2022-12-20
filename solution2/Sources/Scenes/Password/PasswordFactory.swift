import class UIKit.UIViewController

enum PasswordFactory {
    static func make() -> UIViewController {
        let coordinator = PasswordCoordinator()
        let presenter = PasswordPresenter(coordinator: coordinator)
        let interactor = PasswordInteractor(presenter: presenter)
        let viewController = PasswordViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
