//
//  OrderCellViewModel.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

public struct OrderValueViewModel {
    
    let iconImageName: String
    let value: String
    let subtitle: String
    let status: String
    let statusColor: UIColor
    let friendlyDate: String
    
    init(_ entity: OrderEntity, showPaymentMethod: Bool = false) {
        iconImageName = "icon-card"
        value = String(format: "R$%.02f", (entity.value ?? 0))
        
        if showPaymentMethod {
            subtitle = entity.paymentMethod?.rawValue.localized ?? ""
            status = ""
            statusColor = .white
            friendlyDate = ""
        } else {
            subtitle = entity.email ?? ""
            status = entity.status?.rawValue.localized ?? ""
            statusColor = entity.status?.statusColor ?? .cbWhite
            friendlyDate = entity.date?.friendlyDescription() ?? ""
        }
    }
}
