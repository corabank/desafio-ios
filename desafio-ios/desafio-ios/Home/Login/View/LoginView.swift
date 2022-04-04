//
//  LoginView.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 13/03/22.
//

import Foundation
import UIKit

class LoginView: UIView {
    
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
        titleLabel.text = "Bem-vindo de volta!"
        titleLabel.textColor = .gray
        return titleLabel
    }()
    
    lazy var cpfLabel: UILabel = {
        let cpfLabel = UILabel()
        cpfLabel.text = "Qual o seu CPF?"
        cpfLabel.textColor = .black
        cpfLabel.isHighlighted = true
        cpfLabel.font = .boldSystemFont(ofSize: 20)
        return cpfLabel
    }()
    
    lazy var cpfTextField: UITextField = {
        let cpfTextField = UITextField()
        return cpfTextField
    }()
    
    lazy var continueButton: UIButton = {
        let continueButton = UIButton()
        continueButton.layer.cornerRadius = 5
        continueButton.setTitle("Próximo", for: .normal)
        continueButton.backgroundColor = .grayButton
        return continueButton
    }()
    
    func setupViews() {
        container.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cpfLabel.translatesAutoresizingMaskIntoConstraints = false
        cpfTextField.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(cpfLabel)
        container.addSubview(cpfTextField)
        container.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: container.topAnchor, multiplier: 15.00),
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: container.leftAnchor, multiplier: 0.20),
            titleLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.70)
        ])
        
        NSLayoutConstraint.activate([
            cpfLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 0.50),
            cpfLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            cpfLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            cpfLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            cpfTextField.topAnchor.constraint(equalToSystemSpacingBelow: cpfLabel.bottomAnchor, multiplier: 2.00),
            cpfTextField.leftAnchor.constraint(equalTo: cpfLabel.leftAnchor),
            cpfTextField.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.00),
            continueButton.leftAnchor.constraint(equalTo: cpfLabel.leftAnchor),
            continueButton.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
