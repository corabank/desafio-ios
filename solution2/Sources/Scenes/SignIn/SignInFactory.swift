import class UIKit.UIViewController

enum SignInFactory {
    static func make() -> UIViewController {
        let coordinator = SignInCoordinator()
        let presenter = SignInPresenter(coordinator: coordinator)
        let interactor = SignInInteractor(presenter: presenter)
        let viewController = SignInViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
