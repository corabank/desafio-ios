import Foundation

class CouldNotLoginException: NSError {
    init() {
        super.init(domain: "data layer",
                   code: 0,
                   userInfo: [NSLocalizedDescriptionKey: "unexpected error"])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
