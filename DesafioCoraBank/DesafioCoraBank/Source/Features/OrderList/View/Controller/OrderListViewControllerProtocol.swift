//
//  OrderListViewControllerProtocol.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

protocol OrderListViewControllerProtocol: DKAbstractView {
    func updateHeader(viewModel: OrderListHeaderViewModel)
    func updateOrderList(viewModel: [OrderValueViewModel])
    func alertErrorLoadingData()
    func showLoading(_ visible: Bool)
}
