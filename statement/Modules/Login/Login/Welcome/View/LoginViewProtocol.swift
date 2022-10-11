import UIKit

protocol LoginViewProtocol: UIViewController {
    func set(delegate: LoginViewDelegate)
    func tapLogin()
    func tapRegister()
}
