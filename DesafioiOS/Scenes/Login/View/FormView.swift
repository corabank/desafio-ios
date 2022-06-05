//
//  FormView.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

final class FormView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .coraSpacing(.base03)
        return stackView
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .coraSpacing(.base08)
        return stackView
    }()
    
    var button = CoraButton()
    
    var titleLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body1, fontWeight: .regular, color: CoraColor.gray1)
        label.numberOfLines = .zero
        return label
    }()
    
    var titleTextFieldLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .title3, fontWeight: .bold, color: CoraColor.offBlack)
        label.numberOfLines = .zero
        return label
    }()
    
    lazy var textField: CoraTextField = {
        let textField = CoraTextField(frame: .zero)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}

extension FormView: ViewCode {
    
    func buildViewHierarchy() {
        textFieldStackView.addArrangedSubview(titleTextFieldLabel)
        textFieldStackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textFieldStackView)
        stackView.addArrangedSubview(button)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .coraSpacing(.base07)),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.coraSpacing(.base07)),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base07)),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .coraColor(.white)
    }
}
