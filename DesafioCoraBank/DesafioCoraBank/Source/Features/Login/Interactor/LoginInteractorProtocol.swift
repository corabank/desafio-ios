//
//  LoginInteractorProtocol.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

protocol LoginInteractorProtocol: DKAbstractInteractor {
    func loginUser(userName: String, password: String)
}
