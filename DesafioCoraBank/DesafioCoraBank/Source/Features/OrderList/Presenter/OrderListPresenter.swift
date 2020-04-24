//
//  OrderListPresenter.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class OrderListPresenter: DKPresenter {
    fileprivate var view: OrderListViewControllerProtocol? { return self.getAbstractView() as? OrderListViewControllerProtocol }
}

extension OrderListPresenter: OrderListPresenterProtocol {
    func processOrders(entity: OrderListEntity?) {
        guard
            let orderListEntity = entity,
            let orderList = orderListEntity.orderList
        else {
            self.view?.alertErrorLoadingData()
            return
        }
        
        let headerViewModel = OrderListHeaderViewModel(orderListEntity)
        sync{ self.view?.updateHeader(viewModel: headerViewModel) }
        
        var cellViewModelList: [OrderValueViewModel] = []
        for orderEntity in orderList {
            cellViewModelList.append(OrderValueViewModel(orderEntity))
        }
        sync { self.view?.updateOrderList(viewModel: cellViewModelList) }
    }
}
