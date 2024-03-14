//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation

public struct NetworkConstants {
    private init() {}
    
    public static let baseAPIUri = "https://api.challenge.stage.cora.com.br/challenge"
    
    public static let defaultRequestHeaders: RequestHeader = [
        "Content-Type": "application/json",
        "apikey": "09522c5956d056819807bee05197c6bd" // In prod code, this api key should be stored in the keychain, its here just to simplify the flow
    ]
}
