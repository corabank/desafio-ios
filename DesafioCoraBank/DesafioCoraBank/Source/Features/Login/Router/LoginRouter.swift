//
//  LoginRouter.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit
import WizardKit

class LoginRouter: DKAbstractRouter {
    weak var viewController: UIViewController?

    required init() {}
    
    func generateInteractor(_ args: Any?) -> DKAbstractInteractor {
        return LoginInteractor(enableMocks: true)
    }
    
    func generatePresenter(_ args: Any?) -> DKAbstractPresenter {
        return LoginPresenter()
    }
    
    func logIn(user: UserEntity, logoImage: UIView) {
        let destination = OrderListViewController()
        destination.user = user
        destination.setAnimation(CoraCustomAnimation(logoImage: logoImage))
        self.viewController?.present(destination, animated: true, completion: nil)
    }
}
