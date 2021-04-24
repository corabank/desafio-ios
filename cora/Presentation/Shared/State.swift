//
//  State.swift
//  cora
//
//  Created by Lucas Silveira on 20/04/21.
//

import Foundation


/// State.shared.user
/// - Singleton:
/// State.shared.user
class State {
    var user: User?
    static var shared = State()
    
    private init() {}
}
