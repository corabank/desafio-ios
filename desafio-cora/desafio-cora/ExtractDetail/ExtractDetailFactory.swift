import UIKit

enum ExtractDetailFactory {
    static func make(transaction: TransactionDetail, transactionDay: String) -> UIViewController {
        let coordinator: ExtractDetailCoordinating = ExtractDetailCoordinator()
        let presenter: ExtractDetailPresenting = ExtractDetailPresenter(coordinator: coordinator)
        let interactor = ExtractDetailInteractor(presenter: presenter, transaction: transaction, transactionDay: transactionDay)
        let viewController = ExtractDetailViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
