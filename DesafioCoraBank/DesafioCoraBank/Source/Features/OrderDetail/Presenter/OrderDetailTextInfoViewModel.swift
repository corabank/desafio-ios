//
//  OrderDetailTextInfoViewModel.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

public struct OrderDetailTextInfoViewModel {
    let size: OrderDetailTextInfoViewModelSize
    let fieldText: String
    let currency: String
    let valueText: String
    let fontColor: UIColor
    
    init(size: OrderDetailTextInfoViewModelSize, fieldText: String, currency: String, valueText: String, fontColor: UIColor) {
        self.size = size
        self.fieldText = fieldText
        self.currency = currency
        self.valueText = valueText
        self.fontColor = fontColor
    }
    
    var fontSize: CGFloat {
        get { return size == .big ? 16 : 12 }
    }
    
    var cellHeight: CGFloat {
        get { return size == .big ? 50 : 20 }
    }
}

public enum OrderDetailTextInfoViewModelSize {
    case regular,
    big
}
