//
//  UIButton+withLoginButton.swift
//  cora
//
//  Created by Lucas Silveira on 26/04/21.
//

import UIKit

extension UIButton {
    static var loginButton: UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Access my account".localized, for: .normal)
        button.setImage(UIImage(named: "arrow.right"), for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceRightToLeft
        
        var spacing: CGFloat = 0
        switch UIScreen.main.bounds.width {
        case 320.0:
            spacing = -80.dp
        case 375.0, 390.0:
            spacing = -120.dp
        default:
            spacing = -140.dp
        }
        
        button.centerTextAndImage(spacing: spacing)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9820479751, green: 0.2470019758, blue: 0.432462424, alpha: 1)
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = "button"
        
        return button
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
