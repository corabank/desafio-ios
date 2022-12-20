import class UIKit.UIViewController

protocol PasswordCoordinating: AnyObject {
    func coordinateToBankStatement()
}

final class PasswordCoordinator {
    weak var viewController: UIViewController?
}

extension PasswordCoordinator: PasswordCoordinating {
    func coordinateToBankStatement() {
        let scene = BankStatementFactory.make()
        viewController?.show(scene, sender: nil)
    }
}
