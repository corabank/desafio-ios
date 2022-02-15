import Foundation

protocol LoginInteracting: AnyObject {
    func login(_ username: String, password: String)
}

class LoginInteractor: LoginInteracting {
    typealias Dependencies = HasAnalytics
    private let presenter: LoginPresenting
    private let service: LoginServicing
    private let dependencies: Dependencies
    
    init(_ presenter: LoginPresenting, service: LoginServicing, container: Dependencies) {
        self.presenter = presenter
        self.service = service
        self.dependencies = container
    }
    
    func login(_ username: String, password: String) {
        let loginModel = LoginModel(username: username, password: password)
        
        service.requestLogin(loginModel) { [weak self] result in
            switch result {
            case .success(let welcomeMessage):
                self?.presenter.didLoginWith(welcomeMessage)
                self?.logEvent(.success)
            case .failure(let error):
                self?.presenter.somenthingWrongDidHappen(error.localizedDescription)
                self?.logEvent(.failure)
            }
        }
    }
}

private extension LoginInteractor {
    func logEvent(_ event: LoginAnalytics) {
        dependencies.analytics.logEvent(event)
    }
}
