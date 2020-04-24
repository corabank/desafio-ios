//
//  OrderListInteractor.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit
import RogueKit

class OrderListInteractor: DKInteractor {
    fileprivate var presenter: OrderListPresenterProtocol? { return self.getAbstractPresenter() as? OrderListPresenterProtocol }
}

extension OrderListInteractor: OrderListInteractorProtocol {
    func fetchOrderList() {
        RogueKit.request(OrderRepository.fetchOrderList, enableMocks: self.enableMocks) { [unowned self] (result: Result<OrderListEntity, Error>) in
            switch result {
            case let .success(orderList):
                var sortedOrderList = orderList
                sortedOrderList.orderList = sortedOrderList.orderList?.sorted(by: { ($0.date ?? Date()).compare($1.date ?? Date()) == .orderedDescending })
                self.presenter?.processOrders(entity: sortedOrderList)
            case .failure(_):
                self.presenter?.processOrders(entity: nil)
            }
        }
    }
}
