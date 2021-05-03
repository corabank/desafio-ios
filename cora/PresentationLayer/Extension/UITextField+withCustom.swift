//
//  UITextField+withCustom.swift
//  cora
//
//  Created by Lucas Silveira on 26/04/21.
//

import UIKit

extension UITextField {
    /// Customized UITextfield
    /// - Parameter identifier: String
    /// - Parameter placeholder: String
    static func custom(
        withIdentifier identifier: String? = "",
        withPlaceholder placeholder: String? = ""
    ) -> UITextField {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = identifier
        textField.backgroundColor = .clear
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.09308306845, green: 0.1587566097, blue: 0.2415137913, alpha: 1)
        textField.textColor = .white
        textField.font = textField.font?.withSize(12)
        textField.layer.cornerRadius = 20
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardAppearance = .dark
        let customPlaceholderText = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = customPlaceholderText
        textField.returnKeyType = UIReturnKeyType.done
        textField.enablesReturnKeyAutomatically = true
        
        return textField
    }
}
