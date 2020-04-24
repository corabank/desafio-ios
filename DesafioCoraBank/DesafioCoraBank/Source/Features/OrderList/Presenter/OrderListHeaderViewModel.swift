//
//  OrderHeaderViewModel.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

public struct OrderListHeaderViewModel {
    let subtitle: NSAttributedString
    
    init(_ entity: OrderListEntity) {
        
        let totalValue = String(format: "R$ %.02f", (entity.orderTotalValue ?? 0))
        let regularText = "order_header_subtitle".localized
            .replacingOccurrences(of: "ORDER_COUNT", with: "\(entity.orderCount ?? 0)")
            .replacingOccurrences(of: "ORDER_TOTAL_VALUE", with: totalValue)
        
        let lightAttributes = [NSAttributedString.Key.font: UIFont.cbLight(14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let regularAttributes = [NSAttributedString.Key.font: UIFont.cbRegular(14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedText = NSMutableAttributedString(string: regularText, attributes: lightAttributes)
        attributedText.addAttributes(regularAttributes, range: NSRange(location: regularText.count - totalValue.count, length: totalValue.count))
        
        subtitle = attributedText
    }
}
