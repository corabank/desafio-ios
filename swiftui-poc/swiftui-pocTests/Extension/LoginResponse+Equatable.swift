import Foundation
@testable import swiftui_poc

extension LoginResponse: Equatable {
    
    public static func == (lhs: LoginResponse, rhs: LoginResponse) -> Bool {
        return lhs.token == rhs.token
    }
}
