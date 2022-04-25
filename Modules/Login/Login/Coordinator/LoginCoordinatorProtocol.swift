import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func set(navigation: UINavigationController)
    func start(animated: Bool)
    func login()
}
