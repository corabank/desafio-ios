import class UIKit.UIViewController

enum BankStatementFactory {
    static func make() -> UIViewController {
        let service = BankStatementService()
        let coordinator = BankStatementCoordinator()
        let presenter = BankStatementPresenter(coordinator: coordinator)
        let interactor = BankStatementInteractor(service: service, presenter: presenter)
        let viewController = BankStatementViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
