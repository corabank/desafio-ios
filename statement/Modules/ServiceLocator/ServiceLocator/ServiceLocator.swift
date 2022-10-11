import Foundation

public final class ServiceLocator {
    private lazy var instances = [String: Any]()
    public static let shared = ServiceLocator()
    
    private init() {}
    
    public func resolve<T>() -> T? {
        let key = typeName(T.self)
        
        if let instance = instances[key] as? T {
            return instance
        } else {
            return nil
        }
    }
    
    public func register<T>(object: T) {
        let key = typeName(T.self)
        self.instances[key] = object
    }
    
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}
