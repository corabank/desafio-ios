import UIKit

protocol HomeCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class HomeCoordinator {
    weak var viewController: UIViewController?

}

// MARK: - HomeCoordinating
extension HomeCoordinator: HomeCoordinating {
}
