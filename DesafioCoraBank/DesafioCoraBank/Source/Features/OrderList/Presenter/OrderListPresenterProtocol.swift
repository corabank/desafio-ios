//
//  OrderListPresenterProtocol.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

protocol OrderListPresenterProtocol: DKAbstractPresenter {
    func processOrders(entity: OrderListEntity?)
}
