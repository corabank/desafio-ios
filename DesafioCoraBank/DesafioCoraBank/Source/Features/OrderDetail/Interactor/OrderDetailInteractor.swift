//
//  OrderDetailInteractor.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit
import RogueKit

class OrderDetailInteractor: DKInteractor {
    fileprivate var presenter: OrderDetailPresenterProtocol? { return self.getAbstractPresenter() as? OrderDetailPresenterProtocol }
}

extension OrderDetailInteractor: OrderDetailInteractorProtocol {
    func fetchOrderDetail(orderID: String) {
        
        RogueKit.request(OrderRepository.fetchOrder(orderID: orderID), enableMocks: self.enableMocks) { [weak self] (result: Result<OrderEntity, Error>) in
            switch result {
            case let .success(order):
                self?.presenter?.processOrder(entity: order)
            case .failure(_):
                self?.presenter?.processOrder(entity: nil)
            }
        }
    }
}
