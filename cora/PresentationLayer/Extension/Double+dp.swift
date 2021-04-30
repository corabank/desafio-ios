//
//  Double+dp.swift
//  cora
//
//  Created by Lucas Silveira on 21/04/21.
//

import UIKit

extension Double {
    /// Creates balance between devices screen sizes
    var dp: CGFloat {
        return (CGFloat(self) / 320) * UIScreen.main.bounds.width
    }
}
