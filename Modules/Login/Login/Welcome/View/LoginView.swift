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
        stack.spacing = Dimensions.small
        return stack
    }()
    
    private lazy var loginButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Ja sou cliente", alignment: .center, style: .pink)
        button.addTarget(self, action: #selector(loginActionCallback), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Quero fazer parte!", alignment: .left, style: .white)
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
        stack.addArrangedSubview(registerButton)
        stack.addArrangedSubview(loginButton)
    }
    
    func setConstraints() {
        stack.anchor(top: view.topAnchor,
                     leading: view.leadingAnchor,
                     bottom: view.bottomAnchor,
                     trailing: view.trailingAnchor,
                     paddingBottom: Dimensions.small,
                     paddingLeft: Dimensions.medium,
                     paddingRight: Dimensions.medium)
        loginButton.size(height: Dimensions.big)
        loginButton.setWidthEqual(to: stack)
        registerButton.size(height: Dimensions.large)
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
