import Foundation
import RxSwift
@testable import swiftui_poc

class MockLoginUseCase: LoginUseCase {
    
    init() {
        super.init(repository: MockLoginRepository())
    }
    
    var completableValue: Completable!
    override func execute(with params: Params?) -> Completable {
        return completableValue
    }
}
