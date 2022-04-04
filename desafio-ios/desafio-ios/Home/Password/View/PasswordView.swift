//
//  PasswordView.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 18/03/22.
//

import Foundation
import UIKit

class PasswordView: UIView {
    
    init() {
        super.init(frame: .zero)
        self.setupViews()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var container: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Digite sua senha de acesso"
        titleLabel.textColor = .gray
        return titleLabel
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        return passwordTextField
    }()
    
    lazy var continueButton: UIButton = {
        let continueButton = UIButton()
        continueButton.layer.cornerRadius = 5
        continueButton.setTitle("Próximo", for: .normal)
        continueButton.backgroundColor = .grayButton
        return continueButton
    }()
    
    lazy var showPasswordButton: UIButton = {
        let showPasswordButton = UIButton()
        showPasswordButton.setImage(UIImage(named: "eye-hidden"), for: .normal)
        return showPasswordButton
    }()
    
    lazy var resetPasswordButton: UIButton = {
        let resetPasswordButton = UIButton()
        resetPasswordButton.setTitle("Esqueci minha senha", for: .normal)
        resetPasswordButton.setTitleColor(.principal, for: .normal)
        return resetPasswordButton
    }()
    
    func setupViews() {
        container.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(passwordTextField)
        container.addSubview(continueButton)
        container.addSubview(showPasswordButton)
        container.addSubview(resetPasswordButton)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: container.topAnchor, multiplier: 15.00),
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: container.leftAnchor, multiplier: 0.20),
            titleLabel.widthAnchor.constraint(equalTo: container.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2.00),
            passwordTextField.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: container.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 5.00),
            resetPasswordButton.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            resetPasswordButton.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.00),
            continueButton.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            continueButton.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            showPasswordButton.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2.00),
            showPasswordButton.rightAnchor.constraint(equalTo: container.rightAnchor),
            showPasswordButton.leftAnchor.constraint(equalToSystemSpacingAfter: passwordTextField.rightAnchor, multiplier: 0.10)
        ])

        
    }
}
