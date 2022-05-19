import class UIKit.UIViewController

enum TransactionDetailFactory {
    static func make(transactionId: Int) -> UIViewController {
        let service = TransactionDetailService()
        let coordinator = TransactionDetailCoordinator()
        let presenter = TransactionDetailPresenter(coordinator: coordinator)
        let interactor = TransactionDetailInteractor(service: service, presenter: presenter, transactionId: transactionId)
        let viewController = TransactionDetailViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
