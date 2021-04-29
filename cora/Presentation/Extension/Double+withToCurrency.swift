//
//  Double+withToCurrency.swift
//  cora
//
//  Created by Lucas Silveira on 17/04/21.
//

import Foundation

extension Double {
    /// Returns currency string based on device's language and region configuration
    var toCurrency: String {
        let currencyFormatter = NumberFormatter()
        let locale: Locale = Locale.current.identifier == "en" ? .init(identifier: "en_US") : .current
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = locale
        
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}
