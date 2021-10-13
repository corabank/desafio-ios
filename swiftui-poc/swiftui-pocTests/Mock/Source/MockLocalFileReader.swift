import Foundation
import RxSwift
@testable import swiftui_poc

class MockLocalFileReader: LocalFileReader {
    
    static let mocked = MockLocalFileReader()
    
    override init() { }
    
    var requestReturnValue: Single<Decodable>!
    override func read<T>(file: String, extension ext: String) -> Single<T> where T: Decodable {
        return requestReturnValue.asObservable().map { data in
            data as! T
        }.asSingle()
    }
}
