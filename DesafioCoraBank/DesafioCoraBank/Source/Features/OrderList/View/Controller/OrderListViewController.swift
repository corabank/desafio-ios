//
//  OrderListViewController.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class OrderListViewController: DKViewController<OrderListRouter> {
    
    fileprivate var interactor: OrderListInteractorProtocol? { return self.getAbstractInteractor() as? OrderListInteractorProtocol }
    
    /*
        Calling super.viewDidLoad() is mandatory in order to setup the VIP cycle.
    */

    override func viewDidLoad() {
        super.viewDidLoad()

        //Your code here...
    }
    
}

extension OrderListViewController: OrderListViewControllerProtocol {
    func updateHeader(viewModel: OrderListHeaderViewModel) {
        
    }
    
    func updateOrderList(viewModel: [OrderValueViewModel]) {
        
    }
    
    func alertErrorLoadingData() {
        
    }
}

