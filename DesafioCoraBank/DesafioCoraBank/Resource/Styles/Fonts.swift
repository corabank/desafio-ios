//
//  Fonts.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 19/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    
    private static let fontName = "Helvetica"
    
    static func cbRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "\(fontName)", size: size)!
    }
    
    static func cbLight(_ size: CGFloat) -> UIFont {
        return UIFont(name: "\(fontName)-Light", size: size)!
    }
    
    static func cbBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "\(fontName)-Bold", size: size)!
    }
    
    /*static func cbItalic(_ size: CGFloat) -> UIFont {
           return UIFont(name: "\(fontName)-Italic", size: size)!
    }
    
    static func cbLightItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "\(fontName)-LightItalic", size: size)!
    }
    
    static func cbMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "\(fontName)-Medium", size: size)!
    }
    
    static func cbMediumItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "\(fontName)-MediumItalic", size: size)!
    }

    static func cbBoldItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "\(fontName)-BoldItalic", size: size)!
    }*/
}
