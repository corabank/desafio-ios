import UIKit

protocol LoginDisplaying: AnyObject {
    func displaySomething()
}

private extension LoginViewController.Layout {
    // example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class LoginViewController: UIViewController {
    fileprivate enum Layout { 
        // template
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        interactor.doSomething()
    }
    
    private let interactor: LoginInteracting
        
        init(interactor: LoginInteracting) {
            self.interactor = interactor
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

// MARK: - LoginDisplaying
extension LoginViewController: LoginDisplaying {
    func displaySomething() { 
        // template
    }
}
