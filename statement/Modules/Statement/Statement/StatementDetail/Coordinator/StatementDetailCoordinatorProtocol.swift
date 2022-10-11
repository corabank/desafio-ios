import UIKit

protocol StatementDetailCoordinatorProtocol: AnyObject {
    func set(navigation: UINavigationController?)
    func start(statement: StatementItem, owner: Person)
    func back()
}
