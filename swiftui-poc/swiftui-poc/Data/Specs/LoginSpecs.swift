import Foundation

struct LoginRequest: Request {
    private(set) var email: String
    private(set) var password: String
}

struct LoginResponse: Response {
    private(set) var token: String
}
