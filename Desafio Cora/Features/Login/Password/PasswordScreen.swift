//
//  PasswordScreen.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 13/05/22.
//

import UIKit

protocol PasswordScreenDelegate: AnyObject {
    func nextButtonPressed()
    func lostPasswordButtonTapped()
}

final class PasswordScreen: UIView {
    weak var delegate: PasswordScreenDelegate?

    private lazy var passwordTitle: UILabel = {
        let label = UILabel()
        label.text = Strings.passwordTitle
        label.font = Fonts.getFont(.bold(size: 22))()
        label.textColor = .offBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordTextField: UITextField = { // criar um componente para isso para usar no futuro
        let textField = UITextField(frame: .zero)
        let button = UIButton(type: .custom)
        
        button.setImage(Images.eyeHidden, for: .normal)
        button.setImage(Images.rightArrowPink, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(hideShowPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = false
        
        textField.rightView = button
        textField.rightViewMode = .always
        
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.isSecureTextEntry = true
        textField.font = Fonts.getFont(.medium(size: 24))()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var lostPasswordButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(lostPasswordButtonTapped), for: .touchUpInside)
        button.setTitle(Strings.forgotPasswordTitle, for: [])
        button.titleLabel?.font = Fonts.getFont(.regular(size: 14))()
        button.setTitleColor(.primary, for: [])
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.nextButtonTitle, for: [])
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
    
    @objc func lostPasswordButtonTapped() {
        endEditing(true)
        delegate?.lostPasswordButtonTapped()
    }

    @objc func nextButtonTapped() {
        endEditing(true)
        delegate?.nextButtonPressed()
    }

    @objc func hideShowPassword() {
        guard let tfButton = passwordTextField.rightView as? UIButton else { return }
        if tfButton.isSelected {
            passwordTextField.isSecureTextEntry = true
        } else {
            passwordTextField.isSecureTextEntry = false
        }
        tfButton.isSelected = !tfButton.isSelected
    }
    
}

extension PasswordScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(passwordTitle)
        addSubview(passwordTextField)
        addSubview(lostPasswordButton)
        addSubview(nextButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            passwordTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            passwordTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            passwordTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordTitle.bottomAnchor, constant: 32),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])

        NSLayoutConstraint.activate([
            lostPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 48),
            lostPasswordButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            lostPasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
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
                nextButton.topAnchor.constraint(equalTo: lostPasswordButton.bottomAnchor, constant: 80),
                nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
                nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
                nextButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        }
    }
    
    func setupAdditionalConfigaration() {
        backgroundColor = .white
        passwordTextField.becomeFirstResponder()
        nextButton.isEnabled = false
    }
}

extension PasswordScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .gray2
        } else {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .primary
        }
        return true
    }
}
