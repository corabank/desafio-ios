import UIKit

protocol StatementDetailViewProtocol: UIViewController {
    func set(delegate: StatementDetailViewDelegate)
    func setInto(statement: StatementItem, owner: Person)
}
