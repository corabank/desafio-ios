//
//  IntroScreen.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import UIKit

protocol IntroScreenDelegate: AnyObject {
    func buttonSignupPressed()
    func buttonLoginPressed()
}

final class IntroScreen: UIView {
    weak var delegate: IntroScreenDelegate?

// MARK: - Private vars
    private lazy var introBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.introBackground
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var coraLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.coraLogo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var introTitle: UILabel = {
        let label = UILabel()
        label.text = Strings.introTitle
        label.font = Fonts.getFont(.bold(size: 28))()
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var introSubtitle: UILabel = {
        let label = UILabel()
        label.text = Strings.introSubTitle
        label.font = Fonts.getFont(.regular(size: 28))()
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var introBody: UILabel = {
        let label = UILabel()
        label.text = Strings.introBody
        label.font = Fonts.getFont(.regular(size: 16))()
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [introTitle, introSubtitle])
        stackView.spacing = 4.0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(Strings.buttonSignUpTitle, for: .normal)
        button.setTitleColor(.primary, for: [])
        button.layer.cornerRadius = 16
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .white
        button.addImageOnRightSide(Images.rightArrowPink)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.buttonSignInTitle, for: [])
        button.setTitleColor(.white, for: [])
        button.layer.cornerRadius = 16
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpButton, loginButton])
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
@objc private extension IntroScreen {
    func signUpButtonTapped() {
        delegate?.buttonSignupPressed()
    }

    func loginButtonTapped() {
        delegate?.buttonLoginPressed()
    }
}

// MARK: - Extensions
extension IntroScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(introBackground)
        addSubview(coraLogo)
        addSubview(labelsStackView)
        addSubview(introBody)
        addSubview(buttonsStackView)
    }

    func setupConstraints() {
        introBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        introBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        introBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        coraLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: 48).isActive = true
        coraLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        coraLogo.heightAnchor.constraint(equalToConstant: 24).isActive = true

        labelsStackView.topAnchor.constraint(equalTo: introBackground.bottomAnchor, constant: 16).isActive = true
        labelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        labelsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        
        introBody.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 16).isActive = true
        introBody.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        introBody.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        
        buttonsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -48).isActive = true
        buttonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true

        signUpButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    func setupAdditionalConfigaration() {
        backgroundColor = .primary
    }
}
