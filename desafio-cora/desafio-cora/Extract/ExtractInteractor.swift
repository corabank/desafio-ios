import Foundation

protocol ExtractInteracting: AnyObject {
    func doSomething()
}

final class ExtractInteractor {
    private let service: ExtractServicing
    private let presenter: ExtractPresenting

    init(service: ExtractServicing, presenter: ExtractPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - ExtractInteracting
extension ExtractInteractor: ExtractInteracting {
    func doSomething() {
        presenter.displaySomething()
    }
}
