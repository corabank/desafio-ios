import SwiftUI
import RxSwift

final class LoginViewModel: ObservableObject {
    
    @Published var attributes: LoginAttributes
    @Published var state: LoadableState
    
    private let loginUseCase: LoginUseCase
    
    private let coordinator: LoginCoordinator
    
    private let disposeBag = DisposeBag()
    
    init(state: LoadableState = .initial,
         loginUseCase: LoginUseCase,
         coordinator: LoginCoordinator) {
        self.state = state
        self.attributes = LoginAttributes()
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator
    }
    
    func login() {
        self.state = .loading
        
        let params = LoginUseCase.Params(email: attributes.email,
                                         password: attributes.password)
        self.loginUseCase.execute(with: params)
            .subscribe(
                onCompleted: {
                    self.state = .loaded
                    self.coordinator.didLogInSuccessfully()
                }, onError: { error in
                    self.state = .error
                    self.coordinator.didFailLoggingIn()
                }
            ).disposed(by: self.disposeBag)
    }
}

extension LoginViewModel {
    var canSubmit: Bool {
        attributes.email.isNotEmpty && attributes.password.isNotEmpty &&
        state != .loading
    }
}
