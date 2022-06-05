//
//  CoraLabel.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 27/05/22.
//

import UIKit

final class CoraLabel: UILabel {
    init(fontSize: CoraFontSize, fontWeight: UIFont.Weight, color: CoraColor) {
        super.init(frame: .zero)
        textColor = .coraColor(color)
        font = .systemFont(ofSize: fontSize.rawValue, weight: fontWeight)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func setColor(_ coraColor: CoraColor) {
        textColor = coraColor.color()
    }
}
