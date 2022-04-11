import UIKit

enum ExtractFactory {
    static func make() -> UIViewController {
        let service: ExtractServicing = ExtractService()
        let coordinator: ExtractCoordinating = ExtractCoordinator()
        let presenter: ExtractPresenting = ExtractPresenter(coordinator: coordinator)
        let interactor = ExtractInteractor(service: service, presenter: presenter)
        let viewController = ExtractViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
