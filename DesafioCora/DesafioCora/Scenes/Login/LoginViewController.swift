import UIKit

protocol LoginDisplay: AnyObject {
    func errorMessage(_ message: String)
    func disableTextFields()
    func enableTextFields()
    func startButtonLoading()
    func stopButtonLoading()
}

class LoginViewController: UIViewController {
    
    private let interactor: LoginInteracting
    
    init(_ interactor: LoginInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented yet!")
    }
}

extension LoginViewController: LoginDisplay {
    func errorMessage(_ message: String) {
        
    }
    
    func disableTextFields() {
        
    }
    
    func enableTextFields() {
        
    }
    
    func startButtonLoading() {
        
    }
    
    func stopButtonLoading() {
        
    }
}
