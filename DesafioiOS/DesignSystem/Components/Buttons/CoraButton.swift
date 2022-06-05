//
//  CoraButton.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 26/05/22.
//

import UIKit

final class CoraButton: UIButton {
    
    var model: CoraButtonModel?
    let iconImageView = UIImageView(frame: .zero)
    
    override public var isHighlighted: Bool {
        didSet {

            if case .ghost = model?.style {
                return
            }
            
            backgroundColor = isHighlighted ? backgroundColor?.withAlphaComponent(0.9) :  backgroundColor?.withAlphaComponent(1.0)
        }
    }
    
    func render(_ type: RenderType) {
        switch type {
        case .fill(let model):
            self.model = model
            fill(model)
        case .enabled(let isEnabled):
            setEnabled(isEnabled)
        }
    }
    
    private func fill(_ model: CoraButtonModel) {
        setupView()
        iconImageView.image = model.icon
        
        if model.icon != nil {
            contentHorizontalAlignment = .left
            var config = UIButton.Configuration.plain()
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                
                outgoing.font = self.titleLabel?.font
                return outgoing
            }
            
            configuration = config
            configuration?.titlePadding = 16.0
        }
        
        setTitle(model.title, for: .normal)
        stylize(style: model.style)
    }
    
    private func setEnabled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        if let style = model?.style {
            stylize(style: style, isEnabled: isEnabled)
        }
    }
    
    
    private func stylize(style: Style, isEnabled: Bool = true) {
        
        switch style {
        case let .primary(isLight):
            backgroundColor = isLight ? .coraColor(.white) : .coraColor(.primary)
            setTitleColor(isLight ? .coraColor(.primary) : .coraColor(.white), for: .normal)
            setTitleColor(isLight ? .coraColor(.primary) : .coraColor(.white), for: .highlighted)
            setTitleColor(isLight ? .coraColor(.primary) : .coraColor(.white), for: .selected)
            setTitleColor(isLight ? .coraColor(.primary) : .coraColor(.white), for: .disabled)


            titleLabel?.font = .systemFont(ofSize: .coraFont(.body1), weight: .regular)
            setupConstraints(height: ButtonSize.medium.rawValue)
        case .secondary:
            backgroundColor = isEnabled ? .coraColor(.primary) : .coraColor(.gray2)
            layer.borderColor = UIColor.coraColor(.white).cgColor
            layer.borderWidth = 1
            setTitleColor(.coraColor(.white), for: .normal)
            setTitleColor(.coraColor(.white), for: .highlighted)
            setTitleColor(.coraColor(.white), for: .selected)
            setTitleColor(.coraColor(.white), for: .disabled)

            titleLabel?.font = .systemFont(ofSize: .coraFont(.body2), weight: .regular)
            setupConstraints(height: ButtonSize.small.rawValue)
        case .ghost:
            backgroundColor = .clear
            setTitleColor(.coraColor(.primary), for: .normal)
            setTitleColor(.coraColor(.primary), for: .highlighted)
            setTitleColor(.coraColor(.primary), for: .selected)
            setTitleColor(.coraColor(.primary), for: .disabled)
            
            titleLabel?.font = .systemFont(ofSize: .coraFont(.body2), weight: .regular)
            setupConstraints(height: ButtonSize.small.rawValue)
        }
    }
}

extension CoraButton {
    enum ButtonSize: CGFloat {
        case small = 48.0
        case medium = 64.0
    }
}

extension CoraButton: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(iconImageView)
    }
    
    func setupAdditionalConfiguration() {
        layer.cornerRadius = 12
    }
    
    func setupConstraints(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension CoraButton {
    enum Style {
        case primary(isLight: Bool)
        case secondary
        case ghost
    }
    
    enum RenderType {
        case fill(CoraButtonModel)
        case enabled(Bool)
    }
}

extension CoraButton {
    struct CoraButtonModel {
        let style: Style
        let icon: UIImage?
        let title: String
    }
}
