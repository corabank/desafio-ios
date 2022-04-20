import UIKit

enum ExtractAction {
    case signOut
    case filterScene
}

protocol ExtractCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func coordinateToExtractDetail(transaction: TransactionDetail, transactionDay: String)
    func perform(action: ExtractAction)
}

final class ExtractCoordinator {
    weak var viewController: UIViewController?

}

// MARK: - ExtractCoordinating
extension ExtractCoordinator: ExtractCoordinating {
    func coordinateToExtractDetail(transaction: TransactionDetail, transactionDay: String) {
        let vc = ExtractDetailFactory.make(transaction: transaction, transactionDay: transactionDay)
        viewController?.show(vc, sender: nil)
    }
    
    func perform(action: ExtractAction) {
        switch action {
        case .signOut:
            viewController?.navigationController?.popToRootViewController(animated: true)
        case .filterScene:
            print("Filtro")
        }
    }
}
