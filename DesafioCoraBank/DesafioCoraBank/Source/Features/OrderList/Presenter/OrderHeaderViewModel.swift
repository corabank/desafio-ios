//
//  OrderHeaderViewModel.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

public struct OrderHeaderViewModel {
    let subtitle: NSAttributedString
    
    init(_ entity: OrderListEntity) {
        
        let totalValue = String(format: "R$ %.02f", (entity.orderTotalValue ?? 0))
        let regularText = "order_header_subtitle".localized
            .replacingOccurrences(of: "ORDER_COUNT", with: "\(entity.orderCount ?? 0)")
            .replacingOccurrences(of: "ORDER_TOTAL_VALUE", with: totalValue)
        
        let regularAttributes = [NSAttributedString.Key.font: UIFont.cbRegular(14), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let boldAttributes = [NSAttributedString.Key.font: UIFont.cbBold(14), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let attributedText = NSMutableAttributedString(string: regularText, attributes: regularAttributes)
        attributedText.addAttributes(boldAttributes, range: NSRange(location: regularText.count - totalValue.count, length: totalValue.count))
        
        subtitle = attributedText
    }
}
