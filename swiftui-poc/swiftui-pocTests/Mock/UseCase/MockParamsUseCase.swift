import Foundation
@testable import swiftui_poc

class MockParamsUseCase: UseCase {
    
    struct Params {
        private(set) var firstParam: String
        private(set) var secondParam: String
    }
    
    typealias Model = Void
}
