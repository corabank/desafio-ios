//
//  Double+Extensions.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

extension Double {
    var currency: String {
        let numberformatter = NumberFormatter()
        numberformatter.locale = Locale(identifier: "pt_BR")
        numberformatter.numberStyle = .currency
        return numberformatter.string(from: NSNumber(value: self)) ?? ""
    }
}
