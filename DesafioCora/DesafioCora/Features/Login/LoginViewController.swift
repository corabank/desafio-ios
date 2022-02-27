//
//  LoginViewConroller.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation
import UIKit

protocol LoginDisplaying: AnyObject {
    func displayLoading(_ display: Bool)
    func displayError(title: String?, message: String?)
}

class LoginViewController: UIViewController {
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "AWESOME & Co."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Nome ou email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.backgroundColor = UIColor(red: 39/255, green: 63/255, blue: 84/255, alpha: 1.0)
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.backgroundColor = UIColor(red: 39/255, green: 63/255, blue: 84/255, alpha: 1.0)
        return textField
    }()
    
    private lazy var errorLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Acessar minha conta", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Esqueci minha senha", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let interactor: LoginInteracting
    
    init(interactor: LoginInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 21/255, green: 47/255, blue: 68/255, alpha: 1.0)
        view.addSubview(logoImage)
        view.addSubview(topLabel)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(errorLabel)
        view.addSubview(loginButton)
        view.addSubview(forgotPasswordButton)
    }
    
    private func setupConstraints() {
        view.addConstraints([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 128),
            logoImage.heightAnchor.constraint(equalToConstant: 128),
            
            topLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 16),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            usernameField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 48),
            usernameField.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -16),
            
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            errorLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 8),
            
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.bottomAnchor.constraint(equalTo: forgotPasswordButton.topAnchor, constant: -24),
            
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            forgotPasswordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: Actions
    
    @objc
    private func loginButtonTapped() {
        errorLabel.isHidden = true
        interactor.login(username: usernameField.text, password: passwordField.text)
    }
    
    @objc
    private func forgotPasswordButtonTapped() {
        
    }
}

extension LoginViewController: LoginDisplaying {
    func displayLoading(_ display: Bool) {
        
    }
    
    func displayError(title: String?, message: String?) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}
