import Foundation
import RxSwift

/**
 Repository layer was only created thinking about caching
 login response to be used on further authenticated API calls
 
 For the sake of simplicity, it could be avoided since we
 do not call any external API
 */
protocol LoginRepository {
    func login(request: LoginRequest) -> Single<LoginResponse>
}
