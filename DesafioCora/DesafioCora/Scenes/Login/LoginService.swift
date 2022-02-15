import Foundation

struct LoginModel {
    let username: String
    let password: String
}

protocol LoginServicing: AnyObject {
    func requestLogin(_ loginModel: LoginModel, completion: @escaping (Result<String, Error>) -> Void)
}

class LoginService: LoginServicing {
    typealias Dependencies = HasMainThread
    
    private let dependencies: Dependencies
    
    init(_ container: Dependencies) {
        self.dependencies = container
    }
    
    func requestLogin(_ loginModel: LoginModel, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = LoginEndpoint.login(loginModel)
        
        Api.execute(endpoint) { [dependencies] in
            dependencies.mainThread.async {
                completion(.success("Seja bem vindo ao app!"))
            }
        }
    }
}
