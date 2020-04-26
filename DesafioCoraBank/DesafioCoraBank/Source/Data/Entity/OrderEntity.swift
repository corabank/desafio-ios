//
//  OrderEntity.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import RogueKit

public struct OrderEntity: Entity {
    var id: String?
    var value: Double?
    var email: String?
    var status: OrderEntityStatus?
    var date: Date?
    var paymentMethod: OrderPaymentMethod?
    var buyerName: String?
    var taxes: Double?
    var sandbox: String?
}

public enum OrderEntityStatus: String, Entity {
    case paid = "order_status_paid",
    notpaid = "order_status_not_paid",
    waiting = "order_status_waiting"
    
    var statusColor: UIColor {
        get{
            switch self {
            case .paid:
                return .cbGreen
            case .waiting:
                return .cbLightBlue
            case .notpaid:
                return .cbRed
            }
        }
    }
}

public enum OrderPaymentMethod: String, Entity {
    case credit = "order_type_credit"
}
