//
//  LoginAuthView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit
import PaladinKit

final class LoginAuthView: UIView {
    
    public var errorText: String? {
        get { return errorLabel.text }
        set { errorLabel.text = newValue }
    }
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbRed
        label.textAlignment = .center
        return label
    }()
    
    public var loginTextField = CBTextField(type: .login)
    public var passwordTextField = CBTextField(type: .password)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension LoginAuthView: CodeView {
    func buildViewHierarchy() {
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        loginTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: .cbLineBreakMargin).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: .cbLineBreakMargin).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        loginTextField.placeholderText = "login_username_placeholder".localized
        passwordTextField.placeholderText = "login_password_placeholder".localized
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
}

extension LoginAuthView: CBTextFieldDelegate {
    func textfieldValueChanged() {
        errorText = ""
    }
}
