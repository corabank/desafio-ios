import UIKit

public protocol PassFormCoordinatorProtocol: AnyObject {
    func set(navigation: UINavigationController?)
    func start()
    func login()
}
