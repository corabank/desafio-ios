//
//  State.swift
//  cora
//
//  Created by Lucas Silveira on 20/04/21.
//

import Foundation

class State {
    var user: User?
    static var shared = State()
    
    private init() {}
}
