import Foundation
import RxSwift

/**
 The decision to make it a CompletableUseCase is regarding of
 caching token response as described on LoginRepository file.
 
 Since we will not do anything with this response in terms of
 UI updates, we will only need a completed/failure signal
 */
class LoginUseCase: CompletableUseCase {
    struct Params {
        private(set) var email: String
        private(set) var password: String
    }
    typealias Model = Void
    
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func execute(with params: Params?) -> Completable {
        let unwrapped = self.unwrappParams(params)
        let request = LoginRequest(email: unwrapped.email,
                                   password: unwrapped.password)
        return self.repository.login(request: request)
            .asCompletable()
    }
}
