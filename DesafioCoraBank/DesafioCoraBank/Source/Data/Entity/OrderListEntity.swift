//
//  OrderListEntity.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import RogueKit

public struct OrderListEntity: Entity {
    var orderCount: Int?
    var orderTotalValue: Double?
    var orderList: [OrderEntity]?
}
