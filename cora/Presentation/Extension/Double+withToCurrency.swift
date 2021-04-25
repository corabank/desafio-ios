//
//  Double+withToCurrency.swift
//  cora
//
//  Created by Lucas Silveira on 17/04/21.
//

import Foundation

extension Double {
    /// toCurrency
    /// - Returns Localizable String Currency based on devices region
    var toCurrency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
