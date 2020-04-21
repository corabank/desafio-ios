//
//  LoginRouter.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class LoginRouter: DKAbstractRouter {

    required init() {}
    
    func generateInteractor(_ args: Any?) -> DKAbstractInteractor {
        return LoginInteractor()
    }
    
    func generatePresenter(_ args: Any?) -> DKAbstractPresenter {
        return LoginPresenter()
        
    }
}
