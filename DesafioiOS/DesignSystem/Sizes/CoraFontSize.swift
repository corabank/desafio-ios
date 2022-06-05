//
//  CoraFontSize.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 26/05/22.
//

import UIKit

enum CoraFontSize: CGFloat {
    case caption = 12.0
    case body2 = 14.0
    case body1 = 16.0
    case title3 = 22.0
    case title2 = 28.0
    case title1 = 26.0
}

extension CGFloat {
    static func coraFont(_ fontSize: CoraFontSize) -> CGFloat {
        fontSize.rawValue
    }
}
