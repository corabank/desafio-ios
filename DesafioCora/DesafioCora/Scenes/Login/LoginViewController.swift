import UIKit

protocol LoginDisplay: AnyObject {
    
}

class LoginViewController: UIViewController, LoginDisplay {
    
    private let interactor: LoginInteracting
    
    init(_ interactor: LoginInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented yet!")
    }
}
