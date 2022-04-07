import Foundation

protocol HomeInteracting: AnyObject {
    func loginScene()
    func signUpScene()
}

final class HomeInteractor {

    private let presenter: HomePresenting

    init(presenter: HomePresenting) {
        self.presenter = presenter
    }
}

// MARK: - HomeInteracting
extension HomeInteractor: HomeInteracting {
    func loginScene() {
        presenter.didNextStep(action: .login)
    }
    
    func signUpScene() {
        presenter.didNextStep(action: .signUp)
    }
}
