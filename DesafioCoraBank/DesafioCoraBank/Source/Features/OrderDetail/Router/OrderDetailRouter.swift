//
//  OrderDetailRouter.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class OrderDetailRouter: DKAbstractRouter {
    weak var viewController: UIViewController?
    
    required init() {}
    
    func generateInteractor(_ args: Any?) -> DKAbstractInteractor {
        return OrderDetailInteractor(enableMocks: true)
    }
    
    func generatePresenter(_ args: Any?) -> DKAbstractPresenter {
        return OrderDetailPresenter()
    }
}
