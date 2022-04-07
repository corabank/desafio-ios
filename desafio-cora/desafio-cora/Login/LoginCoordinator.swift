import UIKit

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func coordinateToPasswordScene()
}

final class LoginCoordinator {

    weak var viewController: UIViewController?
}

// MARK: - LoginCoordinating
extension LoginCoordinator: LoginCoordinating {
    func coordinateToPasswordScene() {
        let vc = PasswordFactory.make()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
