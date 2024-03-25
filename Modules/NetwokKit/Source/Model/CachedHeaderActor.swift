//
//  CachedHeaderActor.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

actor CachedHeaderActor {
    
    // MARK: - Properties
    
    var data: Token
    
    // MARK: - Initialize
    
    init(_ token: Token = Token(token: "")) {
        self.data = token
    }
    
    // MARK: - Public Methods
    
    func getHeader() async -> [String: String] {
        var header = [String:String]()
        header["token"] = data.token
        header["apikey"] = "59d6eea7877e20f49bd332f39686dda0"
        header["Content-Type"] = "application/json"
        return header
    }
    
    func updateHeaderToken(_ token: Token) async {
        self.data = token
    }
}
