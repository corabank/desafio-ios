import Foundation
import RxSwift
@testable import swiftui_poc

struct MockLoginDataSource: LoginDataSource {
    
    var loginResponseValue: Single<LoginResponse>!
    func performLogin(request: LoginRequest) -> Single<LoginResponse> {
        return loginResponseValue
    }
}
