import class UIKit.UIViewController

protocol BankStatementCoordinating: AnyObject {
    func coordinateToTransactionDetail(id: Int)
}

final class BankStatementCoordinator {
    weak var viewController: UIViewController?
}

extension BankStatementCoordinator: BankStatementCoordinating {
    func coordinateToTransactionDetail(id: Int) {
        let scene = TransactionDetailFactory.make(transactionId: id)
        viewController?.show(scene, sender: nil)
    }
}
