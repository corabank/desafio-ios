import Foundation

class CouldNotParseLocalFileException: NSError {
    init<T>(object: T, file: String, ext: String) {
        super.init(domain: "data layer",
                   code: 1,
                   userInfo: [NSLocalizedDescriptionKey: "could parse \(String(describing: T.self)) from local file \(file).\(ext)"])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
