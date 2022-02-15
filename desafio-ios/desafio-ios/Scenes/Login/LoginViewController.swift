//
//  LoginViewController.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import UIKit
import SnapKit

protocol LoginDisplaying: AnyObject {
    func loginValidation()
    func startLoading()
    func stopLoading()
}

private extension LoginViewController.Layout {
    enum Size {
        static let imageSize = CGSize(width: 220, height: 150)
    }
}

final class LoginViewController: UIViewController {
    fileprivate enum Layout {}
    
    private lazy var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = LayoutSize.Stack.spacing01
        return stack
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: Strings.Image.starkLogo))
        view.layer.masksToBounds = true
        return image
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = Strings.Placeholder.username
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = Strings.Placeholder.passwrod
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var validationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = .zero
        label.text = Strings.CommonMessage.validationErrorMessage
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.setTitle(Strings.CommonMessage.confirmButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(tapToLogin), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = LayoutSize.CornerRadius.base00
        return button
    }()
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        indicator.startAnimating()
        return view
    }()
    
    private let interactor: LoginInteracting
    
    init(interactor: LoginInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
}

extension LoginViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(loginStackView)
        loginStackView.addArrangedSubview(logoImage)
        loginStackView.addArrangedSubview(usernameTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        view.addSubview(confirmButton)
    }
    
    func setupConstraints() {
        view.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        
        loginStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(LayoutSize.View.base02)
            $0.centerY.equalToSuperview().offset(-LayoutSize.View.base02)
        }
        
        logoImage.snp.makeConstraints {
            $0.size.equalTo(Layout.Size.imageSize)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(LayoutSize.View.base02)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(LayoutSize.View.base02)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(LayoutSize.View.base00)
            $0.height.equalTo(LayoutSize.View.base03)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(LayoutSize.View.base01)
        }
    }
    
    func configureViews() {
        view.backgroundColor = .systemGray4
    }
}

// MARK: - LoginDisplaying
extension LoginViewController: LoginDisplaying {
    func loginValidation() {
        loginStackView.addArrangedSubview(validationLabel)
    }
    
    func startLoading() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.trailing.bottom.leading.top.equalToSuperview()
        }
    }
    
    func stopLoading() {
        loadingView.removeFromSuperview()
    }
}

@objc
extension LoginViewController {
    private func tapToLogin() {
        interactor.didLogin(username: usernameTextField.text, password: passwordTextField.text)
    }
}
