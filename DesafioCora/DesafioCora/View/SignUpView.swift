//
//  SignUpView.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 10/03/21.
//

import UIKit

class SignUpView: UIView {
    
    // MARK: - Properties
    
    var signUpAction: (() -> Void)?
    
    // MARK: - Constants
    
    private let viewModel: SignUpViewModel
    
    let logoSignUp: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Cora")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nameSignUpTextField: UITextField = {
        let tf = UITextField("Nome")
        return tf
    }()
    
    let emailSignUpTextField: UITextField = {
        let tf = UITextField("Email")
        return tf
    }()
    
    let passwordSignUpTextFied: UITextField = {
        let tf = UITextField("Password")
        tf.isSecureTextEntry = true
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(title: "Submit", borderColor: UIColor.pinkColorborder)
        button.addTarget(self, action: #selector(signUpBt), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Override & Initializers
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    /// passing registration data to the viewmodel
    func setupUI() {
        guard let currentName = nameSignUpTextField.text,
              let currentEmail = emailSignUpTextField.text,
              let currentPassword = passwordSignUpTextFied.text else { return }
        
        viewModel.name = currentName
        viewModel.mail = currentEmail
        viewModel.password = currentPassword
    }
    
    func setupViewHierarchy() {
        self.addSubview(logoSignUp)
        self.addSubview(nameSignUpTextField)
        self.addSubview(emailSignUpTextField)
        self.addSubview(passwordSignUpTextFied)
        self.addSubview(signUpButton)
        
    }
    
    func setupConstraints() {
        self.logoSignUp.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        self.nameSignUpTextField.snp.makeConstraints { make in
            make.top.equalTo(logoSignUp.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
        self.emailSignUpTextField.snp.makeConstraints { make in
            make.top.equalTo(nameSignUpTextField.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
        self.passwordSignUpTextFied.snp.makeConstraints { make in
            make.top.equalTo(emailSignUpTextField.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
        self.signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordSignUpTextFied.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
    }
    
    /// function to hit the firebase and register the user
    @objc func signUpBt() {
        setupUI()
        signUpAction?()
    }
}
