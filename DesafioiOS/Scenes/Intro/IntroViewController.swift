//
//  IntroViewController.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 27/05/22.
//

import UIKit

final class IntroViewController: CoraViewController<IntroInteracting> {
    typealias Strings = Localization.Intro
    
    private var imageView: UIImageView = {
        let image = Asset.introImage.image
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var logo: UIImageView = {
        let image = Asset.logo.image
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private var titleLabel: CoraLabel = {
        let fontSize: CoraFontSize = UIScreen.main.sizeType == .iPhone5 ? .title1 : .title2
        let label = CoraLabel(fontSize: fontSize, fontWeight: .regular, color: .white)
        label.text = Strings.titleLabel
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body1, fontWeight: .regular, color: .white)
        label.text = Strings.descriptionLabel
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var buttonRegister: CoraButton = {
        let button = CoraButton()
        let icon = Asset.arrowRight.image
        button.render(.fill(.init(style: .primary(isLight: true), icon: icon, title: Strings.buttonRegister)))
        return button
    }()
    
    private lazy var buttonLogin: CoraButton = {
        let button = CoraButton()
        button.render(.fill(.init(style: .secondary, icon: nil, title: Strings.buttonLogin)))
        button.addTarget(self, action: #selector(didTapButtonLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonRegister, buttonLogin])
        stackView.axis = .vertical
        stackView.spacing = .coraSpacing(.base05)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension IntroViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(buttonStackView)
        view.addSubview(logo)
    }
    
    func setupConstraints() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            /// Image Intro
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            
            /// Tiitle Intro
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.coraSpacing(.base07)),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .coraSpacing(.base07)),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .coraSpacing(.base05)),
            
            /// Description Intro
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.coraSpacing(.base07)),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .coraSpacing(.base07)),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .coraSpacing(.base05)),
            
            /// StackView Buttons
            buttonStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .coraSpacing(.base07)),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.coraSpacing(.base07)),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .coraSpacing(.base07)),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.coraSpacing(.base05)),
            
            /// Logo Cora
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .coraSpacing(.base07)),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .coraSpacing(.base07)),
        ])
        
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .coraColor(.primary)
    }
}

@objc
extension IntroViewController {
    func didTapButtonLogin() {
        interactor.openLogin()
    }
}
