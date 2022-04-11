import UIKit

enum ExtractAction {
    // template
}

protocol ExtractCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: ExtractAction)
}

final class ExtractCoordinator {
    weak var viewController: UIViewController?

}

// MARK: - ExtractCoordinating
extension ExtractCoordinator: ExtractCoordinating {
    func perform(action: ExtractAction) {
        // template
    }
}
