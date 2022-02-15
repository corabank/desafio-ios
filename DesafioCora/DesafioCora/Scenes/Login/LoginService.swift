import Foundation

protocol LoginServicing: AnyObject {
    func requestLogin(_ loginModel: LoginModelRequest, completion: @escaping (Result<LoginModelResponse, Error>) -> Void)
}

class LoginService: LoginServicing {
    typealias Dependencies = HasMainThread
    
    private let dependencies: Dependencies
    
    init(_ container: Dependencies) {
        self.dependencies = container
    }
    
    func requestLogin(_ loginModel: LoginModelRequest, completion: @escaping (Result<LoginModelResponse, Error>) -> Void) {
        let endpoint = LoginEndpoint.login(loginModel)
        
        Api<LoginModelResponse>.execute(endpoint) { [dependencies] result in
            dependencies.mainThread.async {
                completion(result)
            }
        }
    }
}
