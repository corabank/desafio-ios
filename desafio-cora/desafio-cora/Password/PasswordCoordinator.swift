import UIKit

protocol PasswordCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class PasswordCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - PasswordCoordinating
extension PasswordCoordinator: PasswordCoordinating {
}
