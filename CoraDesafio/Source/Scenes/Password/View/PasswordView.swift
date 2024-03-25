//
//  PasswordView.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import UIKit
import DesignKit
import CoreKit

protocol PasswordViewDelegate: AnyObject {
    func didTapForgotPassword(_ sender: CoraButtonView)
    func didTapLogginButton(_ sender: CoraButtonView, correctValue: String)
    func didUpdatePasswordText(_ value: String)
}

class PasswordView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: PasswordViewDelegate?
    
    private lazy var stackView: UIStackView = {
        return LayoutHelper.shared.makeStackView(aligment: .leading, spacing: Contants.stackSpacing, axis: .vertical)
    }()
    
    private lazy var titleLabel: UILabel = {
        return LayoutHelper.shared.makeLabel(
            text: CoraStrings.PasswordView.titleLabel,
            alignment: .left,
            numberOfLines: .zero,
            font: .font(Contants.bigFontSize, isBold: true),
            textColor: CoraAssets.lightBlack.color
        )
    }()
    
    private lazy var passwordFieldView: CoraTextFieldView = {
        let viewModel = CoraTextFieldViewModel(
            textField: CoraTextFieldModel(
                type: .custom,
                font: .font(Contants.bigFontSize),
                keyboardType: .default
            ),
            passwordButton: CoraTextFieldPasswordButton(
                hasSecure: true,
                tintColor: CoraAssets.defaultPinkColor.color
            )
        )
        return CoraTextFieldView.instantiate(viewModel, delegate: self)
    }()
    
    private lazy var forgotPasswordButton: CoraButtonView = {
        let viewModel = CoraButtonViewModel(
            title: CoraAccessibleText(text: CoraStrings.PasswordView.forgotPasswordButton, textColor: CoraAssets.defaultPinkColor.color, backgroundColor: .white),
            icon: nil,
            font: .font(Contants.mediumFontSize),
            size: .small)
        
        return CoraButtonView.instantiate(viewModel: viewModel) {[weak self] sender in
            guard let self = self else { return }
            self.delegate?.didTapForgotPassword(sender)
        }
    }()
    
    lazy var confirmButton: CoraButtonView = {
        let viewModel = CoraButtonViewModel(
            title: CoraAccessibleText(text: CoraStrings.Commons.getIn, textColor: .white, backgroundColor: CoraAssets.defaultPinkColor.color),
            icon: .systemImage(CoraStrings.Icons.arrowRight),
            font: .font(Contants.mediumFontSize, isBold: true),
            size: .small
        )
        
        return CoraButtonView.instantiate(viewModel: viewModel) {[weak self] sender in
            guard let self = self else { return }
            self.delegate?.didTapLogginButton(sender, correctValue: passwordFieldView.getValue())
        }
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public Methods
    
    func setPasswordFieldActive() {
        passwordFieldView.textFielView.becomeFirstResponder()
    }
    
    func setEnableButton(_ value: Bool) {
        confirmButton.isEnabled = value
    }
    
    func setLoadingButton() {
        self.confirmButton.isLoading = true
    }
    
    func stopLoadingButton() {
        self.confirmButton.isLoading = false
    }
    
    // MARK: - Private Methods
    
    private func buildComponents() {
        addSubview(stackView)
        stackView.addSubViews([titleLabel, passwordFieldView, forgotPasswordButton])
        addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutHelper.shared.getSafeTopAreaHeight() + Contants.topMarginNavigation),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Contants.mediumMarginSpacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Contants.mediumMarginSpacing),
            
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            
            passwordFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            passwordFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            
            forgotPasswordButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -Contants.mediumMarginSpacing),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: Contants.widthButton),
            
            confirmButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -Contants.mediumMarginSpacing)
        ])
    }
}

// MARK: - CoraTextFieldViewDelegate

extension PasswordView: CoraTextFieldViewDelegate {
    func textDidUpdateText(value: String) {
        delegate?.didUpdatePasswordText(value)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) {
        delegate?.didUpdatePasswordText(passwordFieldView.getValue())
    }
}

// MARK: - Constants

extension PasswordView {
    enum Contants {
        static let mediumMarginSpacing: CGFloat = 16.0
        static let mediumFontSize: CGFloat = 16.0
        static let bigFontSize: CGFloat = 22.0
        static let topMarginNavigation: CGFloat = 20.0
        static let stackSpacing: CGFloat = 20.0
        static let widthButton: CGFloat = 150.0
    }
}
