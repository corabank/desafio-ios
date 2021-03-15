//
//  LoginView.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 09/03/21.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    var loginAction: (() -> Void)?
    var signUpAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupViewHierarchy() {
        self.addSubview(imageLogo)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextFied)
        self.addSubview(loginButton)
        self.addSubview(signUpButton)
    }
    
    let imageLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"Cora")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField("Email")
        tf.text = "euclides.sena@hotmail.com"
        return tf
    }()
    
    let passwordTextFied: UITextField = {
        let tf = UITextField("Password")
        tf.text = "111111"
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(title: "Login", borderColor: UIColor.pinkColorborder)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(title: "Sign Up", borderColor: UIColor.pinkColorborder)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private func setupConstraints() {
        self.imageLogo.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(158)
            make.width.equalTo(128)
        }
        
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(imageLogo.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
        self.passwordTextFied.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
        self.loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFied.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
        self.signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
    }
    
    @objc func handleLogin() {
        loginAction?()
    }
    
    @objc func handleSignUp() {
        signUpAction?()
    }
}
