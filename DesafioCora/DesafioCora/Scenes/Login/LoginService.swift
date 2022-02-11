import Foundation

struct LoginModel {
    let username: String
    let password: String
}

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var params: [String: String] { get }
}

extension Endpoint {
    var baseUrl: String {
        "www.google.com"
    }
}

enum LoginEndpoint: Endpoint {
    case login(_ viewModel: LoginModel)
    
    var path: String {
        "/login"
    }
    
    var params: [String : String] {
        switch self {
        case .login(let viewModel):
            return [
                Keys.username: viewModel.username,
                Keys.password: viewModel.password
            ]
        }
    }
    
    private enum Keys {
        static var username = "username"
        static var password = "password"
    }
}

protocol LoginServicing: AnyObject {
    func requestLogin(_ loginModel: LoginModel, completion: @escaping (Result<String, Error>) -> Void)
}

class Api {
    static func execute(_ endpoint: Endpoint, completion: () -> Void) {
        completion()
    }
}

protocol HasMainThread: AnyObject {
    var mainThread: DispatchQueue { get }
}

protocol AnalyticsProtocol: AnyObject {
    func logEvent(_ eventName: String)
}

protocol HasAnalytics: AnyObject {
    var analytics: AnalyticsProtocol { get }
}

class Analytics: AnalyticsProtocol {
    func logEvent(_ eventName: String) {
        print("did log event with name \(eventName)")
    }
}

typealias Dependencies = HasMainThread & HasAnalytics

class DependencyContainer: Dependencies {
    var mainThread: DispatchQueue = DispatchQueue.main
    var analytics: AnalyticsProtocol = Analytics()
}

class LoginService: LoginServicing {
    typealias Dependencies = HasMainThread
    
    private let dependencies: Dependencies
    
    init(_ container: Dependencies) {
        self.dependencies = container
    }
    
    func requestLogin(_ loginModel: LoginModel, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = LoginEndpoint.login(loginModel)
        
        Api.execute(endpoint) {
            dependencies.mainThread.async {
                completion(.success("Seja bem vindo ao app!"))
            }
        }
    }
}
