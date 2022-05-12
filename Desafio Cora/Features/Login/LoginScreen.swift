//
//  LoginScreen.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import UIKit

final class LoginScreen: UIView {

    lazy var button: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.backgroundColor = .red
        btn.setTitle("Teste", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(button)
    }

    func setupConstraints() {
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true

    }

    func setupAdditionalConfigaration() {
        backgroundColor = .darkGray
    }
}
