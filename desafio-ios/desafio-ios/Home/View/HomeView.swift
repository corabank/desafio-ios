//
//  HomeView.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 12/03/22.
//

import Foundation
import UIKit

class HomeView: UIView {
    
    init() {
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var container: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var imageLogo: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "Logo")
        return imageLogo
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "eduardo-wallpaper-home")
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Conta Digital PJ"
        titleLabel.textColor = .white
        titleLabel.isHighlighted = true
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return titleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Poderosamente simples"
        subtitleLabel.textColor = .white
        return subtitleLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos."
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textColor = .white
        return descriptionLabel
    }()
    
    lazy var signupButton: UIButton = {
        let signupButton = UIButton()
        signupButton.setTitle("Quero fazer parte!", for: .normal)
        signupButton.backgroundColor = .white
        signupButton.setTitleColor(.principal, for: .normal)
        signupButton.layer.cornerRadius = 20
        return signupButton
    }()
    
    lazy var signinButton: UIButton = {
        let signinButton = UIButton()
        signinButton.setTitle("Já sou cliente", for: .normal)
        signinButton.layer.cornerRadius = 20
        signinButton.layer.borderColor = UIColor.white.cgColor
        signinButton.layer.borderWidth = 1
        
        return signinButton
    }()
    
    func setCornerRadius() {
        image.layer.cornerRadius = frame.width/2.2
        image.layer.setNeedsLayout()
    }
}

private extension HomeView {
    
    func setupViews() {
        container.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.principal
        
        self.configureSubviews()
        self.configureSubviewsConstraints()
    }
    
    func configureSubviews() {
        addSubview(container)
        container.addSubview(image)
        container.addSubview(imageLogo)
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
        container.addSubview(descriptionLabel)
        container.addSubview(signinButton)
        container.addSubview(signupButton)
    }
    
    func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: container.topAnchor),
            image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            image.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.45),
            image.widthAnchor.constraint(equalTo: container.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalToSystemSpacingBelow: image.topAnchor, multiplier: 2.00),
            imageLogo.leftAnchor.constraint(equalToSystemSpacingAfter: container.leftAnchor, multiplier: 2.00),
            imageLogo.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.03),
            imageLogo.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.15)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: container.leftAnchor, multiplier: 2.40),
            titleLabel.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.05),
            titleLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.40)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            subtitleLabel.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.05),
            subtitleLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.70)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: subtitleLabel.leftAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.10),
            descriptionLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.80)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 1.70),
            signupButton.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor),
            signupButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.10),
            signupButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.90)
        ])
        
        NSLayoutConstraint.activate([
            signinButton.topAnchor.constraint(equalToSystemSpacingBelow: signupButton.bottomAnchor, multiplier: 2.70),
            signinButton.leftAnchor.constraint(equalTo: signupButton.leftAnchor),
            signinButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.10),
            signinButton.widthAnchor.constraint(equalTo: signupButton.widthAnchor)
        ])
        
    }
    
}
