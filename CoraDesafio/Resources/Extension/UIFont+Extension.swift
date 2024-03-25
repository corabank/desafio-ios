//
//  UIFont+Extension.swift
//  CoraDesafio
//
//  Created by Erik Santos on 13/03/24.
//

import Foundation
import UIKit

extension UIFont {
    
    public static func font(_ size: CGFloat, isBold: Bool = false) -> UIFont {
        if isBold {
            return UIFont(name: CoraStrings.Fonts.bold, size: size) ?? .systemFont(ofSize: 16)
        }
        return UIFont(name: CoraStrings.Fonts.regular, size: size) ?? .systemFont(ofSize: 16)
    }
}
