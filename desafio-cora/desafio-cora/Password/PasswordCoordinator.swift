import UIKit

enum PasswordAction {
    case extractScene
    case lostPassword
}

protocol PasswordCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: PasswordAction)
}

final class PasswordCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - PasswordCoordinating
extension PasswordCoordinator: PasswordCoordinating {
    func perform(action: PasswordAction) {
        switch action {
        case .extractScene:
            let vc = ExtractFactory.make()
            viewController?.show(vc, sender: nil)
        case .lostPassword:
            print("Perdi minha senha")
        }
    }
}
