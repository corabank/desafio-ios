import UIKit

protocol HomePresenting: AnyObject {
    var viewController: HomeDisplay? { get set }
    
    func message(_ message: String)
}

class HomePresenter: HomePresenting {
    private let coordinator: HomeCoordinating
    weak var viewController: HomeDisplay?
    
    init(_ coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
    
    func message(_ message: String) {
        viewController?.welcome(message)
    }
}
