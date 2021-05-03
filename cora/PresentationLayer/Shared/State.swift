//
//  State.swift
//  cora
//
//  Created by Lucas Silveira on 20/04/21.
//

import Foundation

/// Shared user state
class State {
    var user: User?
    static var shared = State()
    
    private init() {
        // not implemented
    }
}
