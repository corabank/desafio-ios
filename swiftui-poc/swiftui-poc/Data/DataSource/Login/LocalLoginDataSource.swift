import Foundation
import RxSwift

struct LocalLoginDataSource: LoginDataSource {
    
    private let generator: DataGenerator
    
    init(generator: DataGenerator) {
        self.generator = generator
    }
    
    func performLogin(request: LoginRequest) -> Single<LoginResponse> {
        let single = Single<LoginResponse>.create { trait in
            let disposables = Disposables.create()
            
            let bool = self.generator.getBool()
            
            guard bool else {
                let exception = CouldNotLoginException()
                trait(.failure(exception))
                return disposables
            }
            
            let response = LoginResponse(token: "local token")
            trait(.success(response))
            
            return disposables
        }
        
        return single
    }
}
