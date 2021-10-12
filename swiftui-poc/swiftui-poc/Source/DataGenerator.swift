import Foundation

class DataGenerator {
    
    static let shared = DataGenerator()
    
    // TODO: This should not be public, find a better way to mock Singleton classes for testing
    init() { }
    
    func getBool() -> Bool {
        return Bool.random()
    }
}
