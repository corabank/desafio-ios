//
//  InitialViewController.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/18/22.
//

import UIKit

class InitialViewController: UIViewController {
    
    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .coraPink
        stackView.spacing = 24
        return stackView
    }()
        
    lazy var logoImageView: UIImageView = {
        let image = UIImage(imageLiteralResourceName: "LogoCoraIntro")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImage(imageLiteralResourceName: "fotoInitialVC")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStack, buttonStack])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Conta Digital PJ\nPoderosamente simples"
        label.font = UIFont(name: "Avenir-Heavy", size: 28)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos."
        label.font = UIFont(name: "Avenir-Roman", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpButton, signInButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 64).isActive = true
        button.layer.cornerRadius = 16
        button.setTitle("Quero fazer parte!", for: .normal)
        button.setTitleColor(UIColor.coraPink, for: .normal)
        button.addTarget(self, action: #selector(actionSignUpButton), for: .touchUpInside)
        return button
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .coraPink
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.layer.cornerRadius = 16
        button.setTitle("Já sou cliente", for: .normal)
        button.addTarget(self, action: #selector(actionSignInButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCodeSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Actions
    
    @objc func actionSignUpButton() {
        print("SIGN UP")
    }
    
    @objc func actionSignInButton() {
        print("SIGN IN")
        CoraLoginRouter.goToLogin(from: self)
    }
}

extension InitialViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(mainStack)
        imageView.addSubview(logoImageView)
    }
    
    func viewCodeConstraintSetup() {
        let padding: CGFloat = 24
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            logoImageView.heightAnchor.constraint(equalToConstant: padding),
            logoImageView.widthAnchor.constraint(equalToConstant: 90),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            
            titleStack.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            titleStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            titleStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    func viewCodeAditionalSetup() {
        let imageWidth = imageView.frame.size.width
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageWidth / 2
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}

