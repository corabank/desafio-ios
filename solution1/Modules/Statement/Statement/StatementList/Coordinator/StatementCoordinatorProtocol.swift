import UIKit

public protocol StatementCoordinatorProtocol: AnyObject {
    func set(navigation: UINavigationController?)
    func start()
    func back()
    func goToDetail(item: StatementItem)
}
