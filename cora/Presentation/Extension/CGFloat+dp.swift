//
//  CGFloat+dp.swift
//  cora
//
//  Created by Lucas Silveira on 21/04/21.
//

import UIKit

extension CGFloat {
    var dp: CGFloat {
        return (self / 320) * UIScreen.main.bounds.width
    }
}
