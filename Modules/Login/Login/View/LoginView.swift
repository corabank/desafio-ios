import Foundation
import UIKit
import ViewCode
import Components

final class LoginView: UIViewController {
    
    private var viewModel: LoginViewDelegate?
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var loginButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Login")
        button.flash()
        button.addTarget(self, action: #selector(loginActionCallback), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Register")
        button.flash()
        button.addTarget(self, action: #selector(registerActionCallback), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) { return nil }
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    @objc
    private func loginActionCallback() {
        print("Login")
    }
    
    @objc
    private func registerActionCallback() {
        print("Register")
    }
}

extension LoginView: ViewCode {
    func setSubviews() {
        view.addSubview(stack)
        stack.addArrangedSubview(loginButton)
        stack.addArrangedSubview(registerButton)
    }
    
    func setConstraints() {
        stack.setAnchorsEqual(to: self.view)
    }
    
    func extraSetups() {
        view.backgroundColor = .systemPink
    }
}

extension LoginView: LoginViewProtocol {
    func set(delegate: LoginViewDelegate) {
        self.viewModel = delegate
    }
}
