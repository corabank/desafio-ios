import UIKit

protocol StatementDetailViewProtocol: UIViewController {
    func set(delegate: StatementDetailViewDelegate)
    func shareAction()
    func cancelAction()
    func setInto(statement: StatementItem,
                 from: Person, to: Person,
                 navigationTitle: String,
                 title: String)
}
