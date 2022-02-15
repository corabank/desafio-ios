import Foundation

protocol HomeInteracting: AnyObject {
    func setup()
}

class HomeInteractor: HomeInteracting {
    typealias Dependencies = HasAnalytics
    private let presenter: HomePresenting
    private let dependencies: Dependencies
    private let message: String
    
    init(_ presenter: HomePresenting, container: Dependencies, message: String) {
        self.presenter = presenter
        self.dependencies = container
        self.message = message
    }
    
    func setup() {
        dependencies.analytics.logEvent(HomeAnalytics.viewed)
        presenter.message(message)
    }
}
