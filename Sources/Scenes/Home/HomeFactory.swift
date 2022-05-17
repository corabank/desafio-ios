import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let coordinator = HomeCoordinator()
        let presenter = HomePresenter(coordinator: coordinator)
        let interactor = HomeInteractor(presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        return viewController
    }
}
