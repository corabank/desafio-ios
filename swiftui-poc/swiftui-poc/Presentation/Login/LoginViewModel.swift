import SwiftUI

final class LoginViewModel: ObservableObject {
    
    @Published var attributes: LoginAttributes
    @Published var state: LoadableState
    
    init(state: LoadableState = .initial) {
        self.state = state
        self.attributes = LoginAttributes()
    }
    
    func login() {
        self.state = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.state = .loaded
        }
    }
}

extension LoginViewModel {
    var canSubmit: Bool {
        attributes.email.isNotEmpty && attributes.password.isNotEmpty &&
        state == .initial
    }
}
