//
//  Extensions.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 09/03/21.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints( _ space: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
