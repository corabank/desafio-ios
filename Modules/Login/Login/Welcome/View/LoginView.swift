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
        button.addTarget(self, action: #selector(loginActionCallback), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Register")
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
        loginButton.flash()
        viewModel?.login()
    }
    
    @objc
    private func registerActionCallback() {
        registerButton.flash()
        viewModel?.register()
    }
}

extension LoginView: ViewCode {
    func setSubviews() {
        view.addSubview(stack)
        stack.addArrangedSubview(UIView(frame: .zero))
        stack.addArrangedSubview(loginButton)
        stack.addArrangedSubview(registerButton)
    }
    
    func setConstraints() {
        stack.setAnchorsEqual(to: self.view)
        loginButton.size(height: 64)
        loginButton.setWidthEqual(to: stack)
        registerButton.size(height: 48)
        registerButton.setWidthEqual(to: stack)
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
