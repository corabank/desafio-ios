//
//  UILabel+withErrorLabel.swift
//  cora
//
//  Created by Lucas Silveira on 26/04/21.
//

import UIKit

extension UILabel {
    static var errorLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = #colorLiteral(red: 0.9820479751, green: 0.2470019758, blue: 0.432462424, alpha: 1)
        label.font = label.font.withSize(11)
        label.textAlignment = .center
        label.accessibilityIdentifier = "errorLabel"
        
        return label
    }
}
