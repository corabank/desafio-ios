import UIKit

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

class LoginCoordinator: LoginCoordinating {
    weak var viewController: UIViewController?
}
