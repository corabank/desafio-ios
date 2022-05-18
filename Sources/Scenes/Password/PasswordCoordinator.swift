import UIKit

protocol PasswordCoordinating: AnyObject {
    func coordinateToBankStatement()
}

final class PasswordCoordinator {
    weak var viewController: UIViewController?
}

extension PasswordCoordinator: PasswordCoordinating {
    func coordinateToBankStatement() {
        
    }
}
