//
//  Double+Extensions.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/25/22.
//

import Foundation

extension Double {
    func doubleToCurrency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_BR")


        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
}
