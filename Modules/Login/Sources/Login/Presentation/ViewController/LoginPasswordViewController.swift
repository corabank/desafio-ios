//
//  LoginPasswordViewController.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 15/03/24.
//

import UIKit
import Core

class LoginPasswordViewController: UIViewController {

    enum LoginPasswordConstants {
        static let eyeIconSize: CGFloat = 32.0
    }
    
    //MARK: - properties
    
    private var viewModel: LoginViewModelProtocol
    private var navigationService: LoginCoordinator?
    
    private let defaultButtonBottomAnchorConstant = -Constants.defaultPadding / 1.25
    
    //MARK: - views
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.secondary
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite sua senha de acesso"
        label.textColor = AppColors.textColorOnWhite
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 22)
        textField.delegate = self
        textField.textColor = AppColors.textColorOnWhite
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let forgotPasswordButton: ButtonView = {
        let button = ButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.text = "Esqueci minha senha"
        button.style = .secondary
        return button
    }()
    
    private let continueButton: ButtonView = {
        let button = ButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.text = "Próximo"
        button.image = Images.General.rightArrowWhite
        button.size = .big
        button.state = .inactive
        return button
    }()
    
    private lazy var eyeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = Images.General.eyeHiddenRed
        imageView.isUserInteractionEnabled = true
        imageView.heightAnchor.constraint(equalToConstant: LoginPasswordConstants.eyeIconSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: LoginPasswordConstants.eyeIconSize).isActive = true
        return imageView
    }()
    
    private lazy var continueButtonBottomAnchor = continueButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: defaultButtonBottomAnchorConstant)
    
    
    //MARK: - setup
    
    init(viewModel: LoginViewModelProtocol, navigationService: LoginCoordinator?) {
        self.viewModel = viewModel
        self.navigationService = navigationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        title = "Login Cora"
    }
    
    private func prepareView() {
        view.backgroundColor = AppColors.navigationBarBackground
        
        prepareContainer()
        prepareTexts()
        prepareInputs()
        prepareIcons()
        
        viewModel.onLoginError = {
            print("[ERROR while trying to login]: \($0)")
        }
        
        viewModel.onLoginSuccess = { [weak self] response in
            UserDefaults.standard.setValue(response.token, forKey: Constants.accessTokenUserDefaultKey)
            
            DispatchQueue.main.async {
                self?.navigationService?.openExtractViewController()
            }
        }
    }
    
    private func prepareContainer() {
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func prepareTexts() {
        container.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: Constants.defaultPadding),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.defaultPadding)
        ])
    }
    
    private func prepareInputs() {
        container.addSubview(textField)
        container.addSubview(forgotPasswordButton)
        container.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: (Constants.defaultPadding * 1.5)),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            forgotPasswordButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.defaultPadding * 2),
            
            continueButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            continueButtonBottomAnchor
        ])
        
        textField.becomeFirstResponder()
        
        continueButton.didTapButton = { [unowned self] in
            viewModel.loginData.password = textField.text ?? ""
            viewModel.didSubmit(login: viewModel.loginData)
        }
    }
    
    private func prepareIcons() {
        container.addSubview(eyeImageView)
        
        NSLayoutConstraint.activate([
            eyeImageView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            eyeImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        
        eyeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEyeIcon)))
    }
    
    //MARK: - actions
    
    @objc 
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, continueButtonBottomAnchor.constant == defaultButtonBottomAnchorConstant {
            continueButtonBottomAnchor.constant -= keyboardSize.height
        }
    }

    @objc 
    private func keyboardWillHide(notification: NSNotification) {
        if continueButtonBottomAnchor.constant != defaultButtonBottomAnchorConstant {
            continueButtonBottomAnchor.constant = defaultButtonBottomAnchorConstant
        }
    }
    
    @objc
    private func didTapEyeIcon() {
        textField.isSecureTextEntry.toggle()
    }
}

//MARK: - text field delegate

extension LoginPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string.isEmpty && range.length > 0), (textField.text ?? "").count <= 1 {
            continueButton.state = .inactive
        } else {
            continueButton.state = viewModel.isValid(password: "\(textField.text ?? "")\(string)") ? .normal : .inactive
        }

        return true
    }
}
