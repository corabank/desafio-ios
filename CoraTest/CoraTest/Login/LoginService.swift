import Foundation

typealias LoginResult = (Result<Bool, Error>) -> Void

protocol LoginServicing {
    func login(with username: String, and pwd: String, completion: LoginResult)
}

final class LoginService: LoginServicing {
    func login(with username: String, and pwd: String, completion: LoginResult) {
        completion(.success(true))
    }
}
