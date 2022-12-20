protocol HomeInteracting: AnyObject {
    func goSignInScene()
}

final class HomeInteractor {
    private let presenter: HomePresenting
    
    init(presenter: HomePresenting) {
        self.presenter = presenter
    }
}

extension HomeInteractor: HomeInteracting {
    func goSignInScene() {
        presenter.presentSignInScene()
    }
}
