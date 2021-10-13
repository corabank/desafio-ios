import Foundation
@testable import swiftui_poc

class MockDataGenerator: DataGenerator {
    
    static let mocked = MockDataGenerator()
    
    override init() { }
    
    var getBoolValue: Bool!
    override func getBool() -> Bool {
        return getBoolValue
    }
}
