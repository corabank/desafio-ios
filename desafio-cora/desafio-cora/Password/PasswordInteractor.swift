import Foundation

protocol PasswordInteracting: AnyObject {
}

final class PasswordInteractor {
    private let presenter: PasswordPresenting

    init(presenter: PasswordPresenting) {
        self.presenter = presenter
    }
}

// MARK: - PasswordInteracting
extension PasswordInteractor: PasswordInteracting {
}
