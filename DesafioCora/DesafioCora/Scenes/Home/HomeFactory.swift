import UIKit

enum HomeFactory {
    static func make(_ message: String, container: DependencyContainer = DependencyContainer()) -> UIViewController {
        let coordinator: HomeCoordinating = HomeCoordinator()
        let presenter: HomePresenting = HomePresenter(coordinator)
        let interactor: HomeInteracting = HomeInteractor(presenter, container: container, message: message)
        let viewController: HomeViewController = HomeViewController(interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController
    }
}
