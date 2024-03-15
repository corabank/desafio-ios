//
//  LoginCPFViewController.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 15/03/24.
//

import UIKit
import Core

class LoginCPFViewController: UIViewController {

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
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bem vindo de volta!"
        label.textColor = AppColors.textColorOnWhite
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Qual seu CPF?"
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
    
    private let continueButton: ButtonView = {
        let button = ButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.text = "Próximo"
        button.image = Images.General.rightArrowWhite
        button.size = .big
        button.state = .inactive
        return button
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
        container.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: Constants.defaultPadding),
            subtitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.defaultPadding),
            subtitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.defaultPadding),
            
            titleLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: (Constants.defaultPadding * 0.25))
        ])
    }
    
    private func prepareInputs() {
        container.addSubview(textField)
        container.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: (Constants.defaultPadding * 1.5)),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            continueButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            continueButtonBottomAnchor
        ])
        
        textField.becomeFirstResponder()
        
        continueButton.didTapButton = { [unowned self] in
            navigationService?.openPasswordScreen(viewModel: viewModel)
        }
    }
    
    //MARK: - keyboard actions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, continueButtonBottomAnchor.constant == defaultButtonBottomAnchorConstant {
            continueButtonBottomAnchor.constant -= keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if continueButtonBottomAnchor.constant != defaultButtonBottomAnchorConstant {
            continueButtonBottomAnchor.constant = defaultButtonBottomAnchorConstant
        }
    }
}

//MARK: - text field delegate

extension LoginCPFViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty && range.length > 0 {
            continueButton.state = .inactive
            return true
       }

        let appendCarac = switch range.location {
        case 3, 7:
            "."
        case 11:
            "-"
        default:
            ""
        }
        
        textField.text?.append(appendCarac)
        
        let willChangeText = (textField.text ?? "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .count < 11
        
        if willChangeText {
            continueButton.state = viewModel.isValid(cpf: "\(textField.text ?? "")\(string)") ? .normal : .inactive
            return true
        }
        
        return false
    }
}
