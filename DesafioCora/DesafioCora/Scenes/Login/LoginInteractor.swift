import Foundation

protocol LoginInteracting: AnyObject {
    
}

class LoginInteractor: LoginInteracting {
    
    private let presenter: LoginPresenting
    private let service: LoginServicing
    
    init(_ presenter: LoginPresenting, service: LoginServicing) {
        self.presenter = presenter
        self.service = service
    }
}
