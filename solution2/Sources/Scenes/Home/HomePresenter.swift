protocol HomePresenting: AnyObject {
    func presentSignInScene()
}

final class HomePresenter {
    private let coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomePresenter: HomePresenting {
    func presentSignInScene() {
        coordinator.coordinateToSignInScene()
    }
}
