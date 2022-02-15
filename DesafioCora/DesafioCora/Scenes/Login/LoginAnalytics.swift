//
//  LoginAnalytics.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation
import Metal

enum LoginAnalytics: AnalyticsEventing {
    case viewed
    case success
    case failure
    
    var name: String {
        switch self {
        case .viewed:
            return Name.viewed
        case .success:
            return Name.success
        case .failure:
            return Name.failure
        }
    }
    
    var context: String {
        Context.login
    }
    
    var properties: [String : String] {
        [
            Keys.mobileOS: Values.mobileOS,
            Keys.appVersion: Values.appVersion
        ]
    }
}
 
private extension LoginAnalytics {
    enum Name {
        static var viewed: String = "Login - Tela Apresentada"
        static var success: String = "Login - Sucesso"
        static var failure: String = "Login - Erro"
    }
    
    enum Context {
        static var login: String = "LoginContext"
    }
    
    enum Keys {
        static var mobileOS: String = "mobile_OS"
        static var appVersion: String = "app_version"
    }
    
    enum Values {
        static var mobileOS: String = "iOS"
        static var appVersion: String = "1.0"
    }
}
