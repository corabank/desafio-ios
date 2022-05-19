import class UIKit.UIViewController

protocol TransactionDetailCoordinating: AnyObject {
}

final class TransactionDetailCoordinator {
    weak var viewController: UIViewController?
}

extension TransactionDetailCoordinator: TransactionDetailCoordinating {

}
