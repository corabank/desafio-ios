//
//  UIFont+Extension.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation
import UIKit

extension UIFont {
    
    public static func font(_ size: CGFloat, isBold: Bool = false) -> UIFont? {
        if isBold {
            return UIFont(name: "Lato-Bold", size: size)
        }
        return UIFont(name: "Lato-Regular", size: size)
    }
}
