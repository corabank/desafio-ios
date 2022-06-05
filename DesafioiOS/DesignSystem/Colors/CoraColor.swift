//
//  CoraColor.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 26/05/22.
//

import UIKit

public enum CoraColor {
    case primary
    case secondary
    case white
    case offBlack
    case gray1
    case gray2
    case gray4
    
    public func color() -> UIColor {
        var color: UIColor
        switch self {
        case .primary:
            color = #colorLiteral(red: 0.9960784314, green: 0.2431372549, blue: 0.4274509804, alpha: 1)
        case .secondary:
            color = #colorLiteral(red: 0.1019607843, green: 0.5764705882, blue: 0.8549019608, alpha: 1)
        case .white:
            color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .offBlack:
            color = #colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.231372549, alpha: 1)
        case .gray1:
            color = #colorLiteral(red: 0.4196078431, green: 0.4392156863, blue: 0.462745098, alpha: 1)
        case .gray2:
            color = #colorLiteral(red: 0.7803921569, green: 0.7960784314, blue: 0.8117647059, alpha: 1)
        case .gray4:
            color = #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
        }
        
        return color
    }
}

extension UIColor {
    class func coraColor(_ colorEnum: CoraColor) -> UIColor {
        colorEnum.color()
    }
}
