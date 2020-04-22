//
//  UserEntity.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 22/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import RogueKit

public struct UserEntity: Entity {
    var userName: String?
    var password: String?
    var accessToken: String?
}
