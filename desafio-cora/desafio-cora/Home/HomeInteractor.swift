import Foundation

protocol HomeInteracting: AnyObject {
    func doSomething()
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
    func doSomething() {
        presenter.displaySomething()
    }
    
    func loginScene() {
        presenter.didNextStep(action: .login)
    }
    
    func signUpScene() {
        presenter.didNextStep(action: .signUp)
    }
}
