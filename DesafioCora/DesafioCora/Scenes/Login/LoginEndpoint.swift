import Foundation

enum LoginEndpoint: EndpointProtocol {
    case login(_ viewModel: LoginModelRequest)
    
    var path: String {
        "/login"
    }
    
    var body: Data? {
        switch self {
        case .login(let viewModel):
            return try? JSONEncoder().encode(viewModel)
        }
    }
}

private extension LoginEndpoint {
    enum Keys {
        static var username = "username"
        static var password = "password"
    }
}
