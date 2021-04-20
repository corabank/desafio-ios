//
//  User.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var email: String
    var orders: [Order] = []
}
