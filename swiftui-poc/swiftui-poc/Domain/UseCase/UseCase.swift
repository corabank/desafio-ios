import Foundation
import RxSwift

protocol UseCase: AnyObject {
    associatedtype Params
    associatedtype Model
}
extension UseCase {
    func unwrappParams(_ params: Params?) -> Params {
        guard let useCaseParams = params else {
            fatalError("UseCase \(String(describing: self)) must have params")
        }
        return useCaseParams
    }
}

protocol CompletableUseCase: UseCase {
    func execute(with params: Params?) -> Completable
}

protocol SingleUseCase: UseCase {
    func execute(with params: Params?) -> Single<Model>
}

protocol MaybeUseCase: UseCase {
    func execute(with params: Params?) -> Maybe<Model>
}

protocol ObservableUseCase: UseCase {
    func execute(with params: Params?) -> Observable<Model>
}
