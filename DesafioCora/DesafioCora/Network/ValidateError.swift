//
//  ValidateError.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import Foundation

import Foundation

class ValidationError: NSError {
    var titleError: String = ""
    var messageError: String = ""
    
    init(titleError: String, messageError: String) {
        super.init(domain: titleError, code: 400, userInfo: [NSLocalizedDescriptionKey: messageError])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
