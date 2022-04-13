import Foundation

protocol ExtractPresenting: AnyObject {
    var viewController: ExtractDisplaying? { get set }
    func displayStatementList(statementData: [StatementData])
    func didNextStep(action: ExtractAction)
}

final class ExtractPresenter {
    private let coordinator: ExtractCoordinating
    weak var viewController: ExtractDisplaying?

    init(coordinator: ExtractCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - ExtractPresenting
extension ExtractPresenter: ExtractPresenting {
    func displayStatementList(statementData: [StatementData]) {
        viewController?.showStatementList(statementList: statementData)
    }
    
    func didNextStep(action: ExtractAction) {
        coordinator.perform(action: action)
    }
}
