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
    }
    
    let imageLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"Cora")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 5
        tf.backgroundColor = UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 0.2)
        tf.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.autocorrectionType = .no
        // placeholder
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]))
        tf.attributedPlaceholder = placeholder
        tf.setLeftPaddingPoints(10)
        return tf
    }()
    
    let passwordTextFied: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 5
        tf.backgroundColor = UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 0.2)
        tf.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.autocorrectionType = .no
        // placeholder
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]))
        tf.attributedPlaceholder = placeholder
        tf.setLeftPaddingPoints(10)
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 255/255, green: 20/255, blue: 47/255, alpha: 1.0).cgColor
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private func setupConstraints() {
        self.imageLogo.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(24)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(158)
            make.width.equalTo(128)
        }
        
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(imageLogo.snp.bottom).offset(24)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
        self.passwordTextFied.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
        
        self.loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFied.snp.bottom).offset(48)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(0)
        }
    }
    
    @objc func handleLogin() {
        loginAction?()
    }
}
