import Foundation
import RxSwift

protocol LoginDataSource {
    func performLogin(request: LoginRequest) -> Single<LoginResponse>
}
