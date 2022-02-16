import Foundation

struct LoginModelRequest: Encodable {
    let username: String
    let password: String
}

struct LoginModelResponse: Decodable {
    let welcome: String
}
