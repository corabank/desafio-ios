import Foundation
import RxSwift

struct LoginRepositoryImpl: LoginRepository {
    
    private let dataSource: LoginDataSource
    
    init(dataSource: LoginDataSource) {
        self.dataSource = dataSource
    }
    
    func login(request: LoginRequest) -> Single<LoginResponse> {
        return self.dataSource.performLogin(request: request)
    }
}
