//
//  LoginViewController.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import UIKit
import Core

class IntroViewController: UIViewController, PresentableLoginView {
    
    enum IntroConstants {
        static let backgroundHeight: CGFloat = 335.0
        static let logoHeight: CGFloat = 24.0
    }
    
    //MARK: - properties
    
    private var navigationService: LoginCoordinator?
    
    //MARK: - views
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.General.coraLogo
        imageView.heightAnchor.constraint(equalToConstant: IntroConstants.logoHeight).isActive = true
        return imageView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.image = Images.Login.backgroundImage
        imageView.heightAnchor.constraint(equalToConstant: IntroConstants.backgroundHeight).isActive = true
        imageView.layer.cornerRadius = IntroConstants.backgroundHeight / 2
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return imageView
    }()
    
    private let curveView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.backgroundColor = AppColors.primary
        return view
    }()
    
    private let contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.primary
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Conta Digital PJ"
        label.textColor = AppColors.secondary
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Poderosamente simples"
        label.textColor = AppColors.secondary
        label.font = .systemFont(ofSize: 28, weight: .regular)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos."
        label.textColor = AppColors.secondary
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.defaultPadding / 1.5
        return stack
    }()
    
    private let makeAccountButton: ButtonView = {
        let button = ButtonView()
        button.text = "Quero fazer parte!"
        button.style = .primaryWhite
        button.image = Images.General.rightArrowRed
        button.size = .big
        return button
    }()
    
    private let alreadyClientButton: ButtonView = {
        let button = ButtonView()
        button.text = "Já sou cliente"
        button.style = .secondary
        return button
    }()
    
    
    //MARK: - setup
    
    init(navigationService: LoginCoordinator) {
        self.navigationService = navigationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationService?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    private func prepareView() {
        prepareBackground()
        prepareTexts()
        prepareButtons()
    }
    
    private func prepareBackground() {
        view.addSubview(curveView)
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(contentContainer)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            curveView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            curveView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            curveView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            curveView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultPadding),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.defaultPadding),
            
            contentContainer.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.layoutIfNeeded()
    }
    
    private func prepareTexts() {
        contentContainer.addSubview(titleLabel)
        contentContainer.addSubview(subtitleLabel)
        contentContainer.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: Constants.defaultPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: Constants.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -Constants.defaultPadding),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.defaultPadding / 1.5),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor)
        ])
    }
    
    private func prepareButtons() {
        contentContainer.addSubview(buttonsStack)
        
        buttonsStack.addArrangedSubview(makeAccountButton)
        buttonsStack.addArrangedSubview(alreadyClientButton)
        
        NSLayoutConstraint.activate([
            buttonsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -Constants.defaultPadding)
        ])
        
        makeAccountButton.didTapButton = continueToCPFScreen
        alreadyClientButton.didTapButton = continueToCPFScreen
    }
    
    private func continueToCPFScreen() {
        navigationService?.openCPFScreen()
    }
}
