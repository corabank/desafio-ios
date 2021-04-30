//
//  User+initWithUserDTO.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

extension User {
    init(userDTO: UserDTO) {
        self.name = userDTO.name
        self.email = userDTO.email
    }
}
