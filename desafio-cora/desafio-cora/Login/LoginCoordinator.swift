import UIKit

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class LoginCoordinator {

    weak var viewController: UIViewController?
}

// MARK: - LoginCoordinating
extension LoginCoordinator: LoginCoordinating {
    
}
