import UIKit

enum ExtractAction {
    case signOut
    case filterScene
    case ExtractDetailScene(transaction: TransactionDetail, transactionDay: String)
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
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func perform(action: ExtractAction) {
        switch action {
        case .signOut:
            viewController?.navigationController?.popToRootViewController(animated: true)
        case .filterScene:
            print("Filtro")
        case .ExtractDetailScene(let transaction, let transactionDay):
            let vc = ExtractDetailFactory.make(transaction: transaction, transactionDay: transactionDay)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
