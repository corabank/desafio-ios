import class UIKit.UIViewController

protocol BankStatementCoordinating: AnyObject {
}

final class BankStatementCoordinator {
    weak var viewController: UIViewController?
}

extension BankStatementCoordinator: BankStatementCoordinating {

}
