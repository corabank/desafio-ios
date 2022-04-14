import UIKit

enum ExtractDetailAction {
    case share
    case cancelTransaction
}

protocol ExtractDetailCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: ExtractDetailAction)
}

final class ExtractDetailCoordinator {
    weak var viewController: UIViewController?

}

// MARK: - ExtractDetailCoordinating
extension ExtractDetailCoordinator: ExtractDetailCoordinating {
    func perform(action: ExtractDetailAction) {
        switch action {
        case .share:
            UIGraphicsBeginImageContextWithOptions((viewController?.view.frame.size)!, false, 3.0)
            viewController?.view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let vc = UIActivityViewController(activityItems: [screenshot as Any], applicationActivities: [])
            viewController?.present(vc, animated: true)
            
        case .cancelTransaction:
            print("Cancelar Transferência")
        }
    }
}
