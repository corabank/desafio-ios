import UIKit

enum HomeAction {
    case login
    case signUp
}

protocol HomeCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: HomeAction)
}

final class HomeCoordinator {
    weak var viewController: UIViewController?
}

private extension HomeCoordinator {
    func showLoginScene() {
        let vc = LoginFactory.make()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - HomeCoordinating
extension HomeCoordinator: HomeCoordinating {
    func perform(action: HomeAction) {
        switch action {
        case .login:
            showLoginScene()
        case .signUp:
            print("Criar conta")
        }
    }
}
