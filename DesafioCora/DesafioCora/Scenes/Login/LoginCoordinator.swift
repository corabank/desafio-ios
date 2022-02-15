import UIKit

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func execute(_ flow: LoginCoordinatorFlow)
}

enum LoginCoordinatorFlow {
    case home(_: String)
}

class LoginCoordinator: LoginCoordinating {
    weak var viewController: UIViewController?
    
    func execute(_ flow: LoginCoordinatorFlow) {
        switch flow {
        case .home(let welcomeMessage):
            viewController?.navigationController?.pushViewController(
                HomeFactory.make(welcomeMessage),
                animated: true
            )

        }
    }
}
