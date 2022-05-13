//
//  LoginScreen.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import UIKit

protocol LoginScreenDelegate: AnyObject {
    func nextButtonPressed()
}

final class LoginScreen: UIView {
    weak var delegate: LoginScreenDelegate?

    private lazy var loginTitle: UILabel = {
        let label = UILabel()
        label.text = Strings.loginTitle
        label.font = Fonts.getFont(.regular(size: 16))()
        label.numberOfLines = 0
        label.textColor = .gray1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginSubtitle: UILabel = {
        let label = UILabel()
        label.text = Strings.loginSubtitle
        label.font = Fonts.getFont(.bold(size: 22))()
        label.numberOfLines = 0
        label.textColor = .offBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTitle, loginSubtitle])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = .numberPad
        textField.backgroundColor = .clear
        textField.tintColor = .offBlack
        textField.textColor = .offBlack
        textField.borderStyle = .none
        textField.font = Fonts.getFont(.medium(size: 24))()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.loginButtonTitle, for: [])
        button.setTitleColor(.white, for: [])
        button.layer.cornerRadius = 16
        button.backgroundColor = .gray2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.addImageOnRightSide(Images.rightArrowWhite)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func nextButtonTapped() {
        endEditing(true)
        delegate?.nextButtonPressed()
    }
}

extension LoginScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(labelsStackView)
        addSubview(loginTextField)
        addSubview(nextButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            labelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            labelsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 32),
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            loginTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        if #available(iOS 15.0, *) {
            NSLayoutConstraint.activate([
                nextButton.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor, constant: -24),
                nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
                nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
                nextButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        } else {
            NSLayoutConstraint.activate([
                nextButton.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 128),
                nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
                nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
                nextButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        }

        if #available(iOS 15.0, *) {
            NSLayoutConstraint.activate([
                nextButton.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor, constant: -24),
                nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
                nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
                nextButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        } else {
            NSLayoutConstraint.activate([
                nextButton.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 128),
                nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
                nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
                nextButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        }
    }

    func setupAdditionalConfigaration() {
        backgroundColor = .white
        loginTextField.becomeFirstResponder()
    }
}

// MARK: - TextField
extension LoginScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = newString.formatCNPJ()
        if text.isValidCNPJ() {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .primary
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .gray2
        }
        return false
    }
}
