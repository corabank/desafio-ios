import UIKit

public protocol LoginCoordinatorProtocol: AnyObject {
    func set(navigation: UINavigationController)
    func start()
    func login()
}
