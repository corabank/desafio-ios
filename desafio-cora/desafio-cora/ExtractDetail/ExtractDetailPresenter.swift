import Foundation

protocol ExtractDetailPresenting: AnyObject {
    var viewController: ExtractDetailDisplaying? { get set }
    func didNextStep(action: ExtractDetailAction)
}

final class ExtractDetailPresenter {
    private let coordinator: ExtractDetailCoordinating
    weak var viewController: ExtractDetailDisplaying?

    init(coordinator: ExtractDetailCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - ExtractDetailPresenting
extension ExtractDetailPresenter: ExtractDetailPresenting {
    func didNextStep(action: ExtractDetailAction) {
        coordinator.perform(action: action)
    }
}
