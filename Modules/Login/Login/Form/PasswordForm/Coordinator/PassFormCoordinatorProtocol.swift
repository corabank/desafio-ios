import UIKit

protocol PassFormCoordinatorProtocol: AnyObject {
    func set(navigation: UINavigationController?)
    func back()
    func start()
    func goToStatement()
}

