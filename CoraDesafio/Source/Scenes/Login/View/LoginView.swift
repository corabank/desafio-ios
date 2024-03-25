//
//  LoginViewController.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import UIKit
import CoreKit
import DesignKit

protocol LoginViewDelegate: AnyObject {
    func didTapConfirmButton(_ button: CoraButtonView, correctValue: String)
    func didUpdateCpfText(_ value: String)
}

class LoginView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: LoginViewDelegate?
    
    private lazy var stackView: UIStackView = {
        return LayoutHelper.shared.makeStackView(
            aligment: .leading,
            spacing: Contants.mediumMarginSpacing,
            axis: .vertical
        )
    }()
    
    private lazy var welcomeLabel: UILabel = {
        return LayoutHelper.shared.makeLabel(
            text: CoraStrings.LoginView.welcomeDescription,
            alignment: .left,
            numberOfLines: .zero,
            font: .font(Contants.mediumFontSize),
            textColor: CoraAssets.darkGray.color
        )
    }()
    
    private lazy var cpfDescriptionLabel: UILabel = {
        return LayoutHelper.shared.makeLabel(
            text:CoraStrings.LoginView.cpfDesciption,
            alignment: .left,
            numberOfLines: .zero,
            font: .font(Contants.bigFontSize, isBold: true),
            textColor: CoraAssets.lightBlack.color
        )
    }()
    
    private lazy var cpfFieldView: CoraTextFieldView = {
        let viewModel = CoraTextFieldViewModel(
            textField: CoraTextFieldModel(
                type: .cpf,
                font: .font(Contants.bigFontSize),
                keyboardType: .numberPad
            )
        )
        return CoraTextFieldView.instantiate(viewModel, delegate: self)
    }()
    
    private lazy var confirmButton: CoraButtonView = {
        let viewModel = CoraButtonViewModel(
            title: CoraAccessibleText(text: CoraStrings.Commons.next, textColor: .white, backgroundColor: CoraAssets.defaultPinkColor.color),
            icon: .systemImage(CoraStrings.Icons.arrowRight),
            font: .font(Contants.mediumFontSize, isBold: true),
            size: .small
        )
        
        return CoraButtonView.instantiate(viewModel: viewModel) {[weak self] sender in
            guard let self = self else { return }
            self.delegate?.didTapConfirmButton(sender, correctValue: cpfFieldView.getValue())
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
    
    func setCpfFieldActive() {
        cpfFieldView.textFielView.becomeFirstResponder()
    }
    
    func setEnableButton(_ value: Bool) {
        confirmButton.isEnabled = value
    }
    
    // MARK: - Private Methods
    
    private func buildComponents() {
        addSubview(stackView)
        stackView.addSubViews([welcomeLabel, cpfDescriptionLabel, cpfFieldView])
        addSubview(confirmButton)
    
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutHelper.shared.getSafeTopAreaHeight() + Contants.topMarginNavigation),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Contants.mediumMarginSpacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Contants.mediumMarginSpacing),
            
            welcomeLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            
            cpfDescriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            cpfDescriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            
            cpfFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            cpfFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            
            confirmButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -Contants.mediumMarginSpacing)
        ])
    }
}

// MARK: - CoraTextFieldViewDelegate

extension LoginView: CoraTextFieldViewDelegate {
    func textDidUpdateText(value: String) {
        delegate?.didUpdateCpfText(value)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) {
        /* Intentionaly Implemented */
    }
}

// MARK: - Constants

extension LoginView {
    enum Contants {
        static let mediumMarginSpacing: CGFloat = 16.0
        static let mediumFontSize: CGFloat = 16.0
        static let bigFontSize: CGFloat = 22.0
        static let topMarginNavigation: CGFloat = 20.0
    }
}
