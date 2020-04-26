//
//  OrderListRouter.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class OrderListRouter: DKAbstractRouter {
    weak var viewController: UIViewController?
    
    required init() {}
    
    func generateInteractor(_ args: Any?) -> DKAbstractInteractor {
        return OrderListInteractor(enableMocks: true)
    }
    
    func generatePresenter(_ args: Any?) -> DKAbstractPresenter {
        return OrderListPresenter()
    }
    
    func showDetail(orderID: String) {
        let destination = OrderDetailViewController()
        destination.orderID = orderID
        self.viewController?.present(destination, animated: true, completion: nil)
    }
}
