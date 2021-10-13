import Foundation
import RxSwift
@testable import swiftui_poc

struct MockLoginRepository: LoginRepository {
    
    var loginResponseValue: Single<LoginResponse>!
    func login(request: LoginRequest) -> Single<LoginResponse> {
        return loginResponseValue
    }
}
