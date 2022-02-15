//
//  Api.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation

class Api {
    static func execute(_ endpoint: EndpointProtocol, completion: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            completion()
        }
    }
}
