import UIKit

public protocol StatementCoordinatorProtocol: AnyObject {
    func set(navigation: UINavigationController?)
    func start()
}
