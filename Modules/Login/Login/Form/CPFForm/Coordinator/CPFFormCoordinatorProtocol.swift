import UIKit

public protocol CPFFormCoordinatorProtocol: AnyObject {
    func set(navigation: UINavigationController?)
    func start()
    func login()
}
