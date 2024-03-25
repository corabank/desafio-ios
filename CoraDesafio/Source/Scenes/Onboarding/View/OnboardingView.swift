//
//  OnboadingView.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import UIKit
import CoreKit
import DesignKit

protocol OnboadingViewDelegate: AnyObject {
    func didTapLogin(_ button: CoraButtonView)
    func didTapRegister(_ button: CoraButtonView)
}

class OnboardingView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: OnboadingViewDelegate?

    private lazy var logoTitle: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = CoraAssets.coraLogoTitle.image
        return image
    }()
    
    private lazy var imagePerson: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = CoraAssets.onboardingPessoa.image
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        return LayoutHelper.shared.makeStackView(
            aligment: .center,
            spacing: Contants.mediumMarginSpacing,
            axis: .vertical
        )
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = LayoutHelper.shared.makeLabel(
            text: CoraStrings.OnboardingView.titleLabel,
            alignment: .left,
            numberOfLines: 2,
            font: .font(Contants.bigFontSize),
            textColor: .white
        )
        let labelWithBold = LayoutHelper.shared.makeBold(titleLabel, textBold: CoraStrings.OnboardingView.titleLabelBold, fontBold: .font(Contants.bigFontSize, isBold: true))
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let labelDefault = LayoutHelper.shared.makeLabel(
            text: CoraStrings.OnboardingView.descriptionLabel,
            alignment: .left,
            numberOfLines: .zero,
            font: .font(Contants.mediumFontSize),
            textColor: .white
        )
        
        let labelCustomHeight = LayoutHelper.shared.adjustLineHeight(labelDefault, height: 24)
        return labelCustomHeight
    }()
    
    private lazy var registerButton: CoraButtonView = {
        let viewModel = CoraButtonViewModel(
            title: CoraAccessibleText(text: CoraStrings.OnboardingView.registerButton, textColor: CoraAssets.defaultPinkColor.color, backgroundColor: .white),
            icon: .systemImage(CoraStrings.Icons.arrowRight),
            font: .font(Contants.mediumFontSize, isBold: true),
            size: .tall
        )
        
        return CoraButtonView.instantiate(viewModel: viewModel) {[weak self] sender in
            guard let self = self else { return }
            self.delegate?.didTapRegister(sender)
        }
    }()
    
    private lazy var loginButton: CoraButtonView = {
        let viewModel = CoraButtonViewModel(
            sideType: .center,
            title: CoraAccessibleText(text: CoraStrings.OnboardingView.loginButton, textColor: .white, backgroundColor: CoraAssets.defaultPinkColor.color),
            icon: nil,
            font: .font(Contants.mediumFontSize, isBold: true),
            size: .tall
        )
        
        return CoraButtonView.instantiate(viewModel: viewModel) {[weak self]  sender in
            guard let self = self else { return }
            self.delegate?.didTapLogin(sender)
        }
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildComponent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Initialize
    
    private func buildComponent() {
        addSubview(imagePerson)
        addSubview(logoTitle)
        addSubview(stackView)
        
        stackView.addSubViews([titleLabel, descriptionLabel, registerButton, loginButton])
        
        NSLayoutConstraint.activate([
            imagePerson.topAnchor.constraint(equalTo: topAnchor),
            imagePerson.leadingAnchor.constraint(equalTo: leadingAnchor),
            imagePerson.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            logoTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logoTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Contants.mediumMarginSpacing),
            
            stackView.topAnchor.constraint(equalTo: imagePerson.bottomAnchor, constant: Contants.mediumMarginSpacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Contants.mediumMarginSpacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Contants.mediumMarginSpacing),
            
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            registerButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        stackView.setCustomSpacing(Contants.stackSpacing, after: descriptionLabel)
    }
}

// MARK: - Contants

extension OnboardingView {
    enum Contants {
        static let mediumMarginSpacing: CGFloat = 16.0
        static let mediumFontSize: CGFloat = 16.0
        static let bigFontSize: CGFloat = 28.0
        static let stackSpacing: CGFloat = 20.0
    }
}
