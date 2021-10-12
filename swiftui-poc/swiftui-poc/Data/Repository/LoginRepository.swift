import Foundation
import RxSwift

protocol LoginRepository {
    func login(request: LoginRequest) -> Single<LoginResponse>
}
