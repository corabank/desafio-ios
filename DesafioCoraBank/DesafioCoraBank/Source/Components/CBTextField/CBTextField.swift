//
//  CBTextField.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 19/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit
import PaladinKit

public enum CBTextFieldType: String {
    case login = "icon-login",
    password = "icon-password"
}

final class CBTextField: UIView {
    
    public weak var delegate: CBTextFieldDelegate?
    private var type: CBTextFieldType
    
    public var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
            textField.accessibilityValue = newValue
            valueChanged()
        }
    }
    
    public var placeholderText: String? {
        didSet {
            textField.setPlaceholderColor(placeholder: placeholderText ?? "", color: .cbDarkGray)
            textField.accessibilityLabel = placeholderText
            movingLabel.text = placeholderText
        }
    }
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: type.rawValue)
        imageView.tintColor = .cbWhite
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .cbWhite
        textField.font = .cbLight(16)
        textField.keyboardAppearance = .dark
        textField.isAccessibilityElement = true
        textField.accessibilityTraits = .keyboardKey
        return textField
    }()
    
    private lazy var movingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbDarkGray
        label.font = .cbRegular(12)
        label.isAccessibilityElement = false
        return label
    }()
    
    private lazy var hiddenImage = UIImage(named: "icon-hidden")
    private lazy var visibleImage = UIImage(named: "icon-visible")
    
    private lazy var eyeImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = hiddenImage
        imageView.tintColor = .cbPink
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = true
        imageView.accessibilityTraits = .image
        imageView.accessibilityLabel = "toggle_security".localized
        imageView.accessibilityValue = "false"
        return imageView
    }()
    
    init(_ frame: CGRect = .zero, type: CBTextFieldType) {
        
        self.type = type
        
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension CBTextField: CodeView {
    func buildViewHierarchy() {
        addSubview(iconImage)
        addSubview(textField)
        addSubview(movingLabel)
        addSubview(eyeImage)
    }
    
    func setupConstraints() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        textField.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: .cbLeftMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: eyeImage.leadingAnchor, constant: .cbRightMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        eyeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: type == .password ? .cbRightMargin : 0).isActive = true
        eyeImage.widthAnchor.constraint(equalToConstant: type == .password ? 20 : 0).isActive = true
        eyeImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        eyeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        movingLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: .cbLeftMargin).isActive = true
        movingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        movingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        movingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        eyeImage.isHidden = type != .password
        backgroundColor = UIColor.cbWhite.withAlphaComponent(0.2)
        layer.cornerRadius = .cbCornerRadius
        movingLabel.alpha = 0
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        textField.isSecureTextEntry = type == .password
        setupEyeGesture()
    }
    
    @objc private func valueChanged() {
        
        let currentText = textField.text ?? ""
        textField.accessibilityValue = currentText
        
        if(currentText.isEmpty) {
            self.textField.alpha = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.movingLabel.alpha = 0
                self.movingLabel.transform = .identity
                self.textField.alpha = 1
                self.textField.transform = .identity
            }, completion:nil)
        }
        else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.movingLabel.alpha = 1
                self.movingLabel.transform = CGAffineTransform(translationX: 0, y: -10)
                self.textField.transform = CGAffineTransform(translationX: 0, y: 10)
            }, completion:nil)
        }
        
        delegate?.textfieldValueChanged()
    }
    
    private func setupEyeGesture() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(toogleSecurity))
        touchGesture.numberOfTouchesRequired = 1
        eyeImage.addGestureRecognizer(touchGesture)
        eyeImage.isUserInteractionEnabled = true
    }
    
    @objc func toogleSecurity() {
        
        let text = textField.text ?? ""
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        
        if textField.isSecureTextEntry  {
            textField.text?.removeAll()
            textField.insertText(text)
        }
        
        eyeImage.image = textField.isSecureTextEntry ? hiddenImage : visibleImage
        eyeImage.accessibilityValue = "\(!textField.isSecureTextEntry)"
    }
}

protocol CBTextFieldDelegate: class {
    func textfieldValueChanged()
}
