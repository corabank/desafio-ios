//
//  OrderDetailViewController.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class OrderDetailViewController: DKViewController<OrderDetailRouter> {
    
    fileprivate var interactor: OrderDetailInteractorProtocol? { return self.getAbstractInteractor() as? OrderDetailInteractorProtocol }
    
    /*
        Calling super.viewDidLoad() is mandatory in order to setup the VIP cycle.
    */

    override func viewDidLoad() {
        super.viewDidLoad()

        //Your code here...
    }
    
}

extension OrderDetailViewController: OrderDetailViewControllerProtocol {
    func addValueCell(viewModel: OrderValueViewModel) {
        
    }
    
    func addIconInfoCell(viewModel: OrderDetailIconInfoViewModel) {
        
    }
    
    func addSectionHeaderCell(viewModel: OrderDetailSectionHeaderViewModel) {
        
    }
    
    func addTextInfoCell(viewModel: OrderDetailTextInfoViewModel) {
        
    }
    
    func addSandboxCell(viewModel: OrderDetailSandboxViewModel) {
        
    }
    
    func alertErrorLoadingData() {
        
    }
}
