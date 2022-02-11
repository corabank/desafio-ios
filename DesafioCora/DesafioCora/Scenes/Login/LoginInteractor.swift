import Foundation

protocol LoginInteracting: AnyObject {
    func login(_ username: String, password: String)
}

class LoginInteractor: LoginInteracting {
    typealias Dependencies = HasAnalytics
    private let presenter: LoginPresenting
    private let service: LoginServicing
    
    init(_ presenter: LoginPresenting, service: LoginServicing, container: Dependencies) {
        self.presenter = presenter
        self.service = service
    }
    
    func login(_ username: String, password: String) {
        let loginModel = LoginModel(username: username, password: password)
        
        service.requestLogin(loginModel) { [presenter] result in
            switch result {
            case .success(let welcomeMessage):
                presenter.didLoginWith(welcomeMessage)
            case .failure(let error):
                presenter.somenthingWrongDidHappen(error.localizedDescription)
            }
        }
    }
}
