import Foundation
import RxSwift

struct LocalLoginDataSource: LoginDataSource {
    
    let generator: DataGenerator
    
    init(generator: DataGenerator) {
        self.generator = generator
    }
    
    func performLogin(request: LoginRequest) -> Single<LoginResponse> {
        let single = Single<LoginResponse>.create { trait in
            // remover daqui, se isso estiver aqui não da pra testar!
            let bool = self.generator.getBool()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
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
