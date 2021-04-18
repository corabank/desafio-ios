//
//  String+isValidEmail.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

extension String {
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
