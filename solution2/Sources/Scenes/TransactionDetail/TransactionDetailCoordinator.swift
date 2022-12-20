import UIKit

protocol TransactionDetailCoordinating: AnyObject {
    func coordinateToActivityController(shareItem: UIImage)
}

final class TransactionDetailCoordinator {
    weak var viewController: UIViewController?
}

extension TransactionDetailCoordinator: TransactionDetailCoordinating {
    func coordinateToActivityController(shareItem: UIImage) {
        let items = [shareItem as Any]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController?.present(activityViewController, animated: true)
    }
}
