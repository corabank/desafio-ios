import Foundation
import RxSwift

class LocalFileReader {
    
    static let shared = LocalFileReader()
    
    // TODO: This should not be public, find a better way to mock Singleton classes for testing
    init() { }
    
    func read<T: Decodable>(file: String, extension ext: String) -> Single<T> {
        let single = Single<T>.create { trait in
            let disposables = Disposables.create()
            
            guard let url = Bundle.main.url(forResource: file, withExtension: ext),
                  let data = try? Data(contentsOf: url),
                  let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                      //TODO: We can split these three unwraps to treat diferent exceptions
                      let exception = CouldNotParseLocalFileException(object: T.self, file: file, ext: ext)
                      trait(.failure(exception))
                      return disposables
            }
            
            trait(.success(decoded))
            return disposables
        }
        
        return single
    }
}
