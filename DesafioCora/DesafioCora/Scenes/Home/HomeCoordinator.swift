import UIKit

protocol HomeCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func execute(_ flow: HomeCoordinatorFlow)
}

enum HomeCoordinatorFlow { }

class HomeCoordinator: HomeCoordinating {
    weak var viewController: UIViewController?
    
    func execute(_ flow: HomeCoordinatorFlow) { }
}
