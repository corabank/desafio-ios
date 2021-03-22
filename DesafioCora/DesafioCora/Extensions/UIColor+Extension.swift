//
//  UIColor+Extension.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 10/03/21.
//

import UIKit

// MARK: - Extensions

extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static var pinkColorborder: UIColor = {
        return UIColor(r: 255, g: 20, b: 47)
    }()
}
