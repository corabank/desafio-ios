import UIKit

protocol HomeCoordinating: AnyObject {
    func coordinateToSignInScene()
}

final class HomeCoordinator {
    weak var viewController: UIViewController?
}

extension HomeCoordinator: HomeCoordinating {
    func coordinateToSignInScene() {
        
    }
}
