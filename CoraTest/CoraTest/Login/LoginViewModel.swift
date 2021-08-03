import Foundation

protocol LoginViewModeling {
    func login(with username: String, and pwd: String)
}


final class LoginViewModel: LoginViewModeling {
    private let service: LoginServicing
    private let coordinator: LoginCoordinating
    
    init(service: LoginServicing, coordinator: LoginCoordinating) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func login(with username: String, and pwd: String) {
        service.login(with: username, and: pwd) { result in
            switch result {
                case let .success(deuCerto):
                    if deuCerto {
                        coordinator.goToHomeScreen()
                    }
                case .failure:
                    fatalError()
            }
        }
    }
}
