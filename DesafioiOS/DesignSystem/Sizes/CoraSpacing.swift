//
//  CoraSpacing.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import UIKit

enum CoraSpacing: CGFloat {    
    case base00 = 1.0
    case base01 = 4.0
    case base02 = 6.0
    case base03 = 8.0
    case base04 = 12.0
    case base05 = 16.0
    case base06 = 18.0
    case base07 = 24.0
    case base08 = 32.0
    case base09 = 44.0
    case base10 = 48.0
    case base11 = 56.0
    case base12 = 64.0
}

extension CGFloat {
    static func coraSpacing(_ spacing: CoraSpacing) -> CGFloat {
        spacing.rawValue
    }
}
