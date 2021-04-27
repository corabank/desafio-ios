//
//  CGRect+withZeroForAccessibility.swift
//  cora
//
//  Created by Lucas Silveira on 27/04/21.
//

import UIKit

extension CGRect {
    static var zeroForAccessibility: CGRect {
        CGRect(x: 0, y: 0, width: 1, height: 1)
    }
}
