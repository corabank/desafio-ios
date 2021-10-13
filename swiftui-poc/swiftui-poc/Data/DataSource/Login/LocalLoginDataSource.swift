import Foundation
import RxSwift

struct LocalLoginDataSource: LoginDataSource {
    
    private let generator: DataGenerator
    
    init(generator: DataGenerator) {
        self.generator = generator
    }
    
    func performLogin(request: LoginRequest) -> Single<LoginResponse> {
        let single = Single<LoginResponse>.create { trait in
            let bool = self.generator.getBool()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                guard bool else {
                    let exception = CouldNotLoginException()
                    trait(.failure(exception))
                    return
                }
                
                let response = LoginResponse(token: "local token")
                trait(.success(response))
            }
            
            return Disposables.create()
        }
        
        return single
    }
}
