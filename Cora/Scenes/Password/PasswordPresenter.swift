final class PasswordPresenter {
    private let document: String
    weak var controller: PasswordControllerType?

    init(document: String) {
        self.document = document
    }
}

extension PasswordPresenter: PasswordPresenterType {
    func login(password: String) {
        /*
         Make repository call to login and back to controller to keep the flow.
         */
        controller?.loggedIn()
    }
}
