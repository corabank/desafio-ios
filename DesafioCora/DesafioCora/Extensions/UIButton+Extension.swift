//
//  UIButton+Extension.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 10/03/21.
//

import UIKit

extension UIButton {
    public convenience init(title: String, borderColor: UIColor) {
        self.init()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.black]))
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
    }
}
