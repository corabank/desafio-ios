//
//  Double+Extension.swift
//  desafio-ios
//
//  Created by Barbara Barone on 14/02/22.
//

import Foundation

extension Double {
    func formatCurrency() -> String? {
        let number = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: Strings.Locale.usa)
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: number)
    }
}
