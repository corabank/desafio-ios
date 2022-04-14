//
//  CurrencyString.swift
//  desafio-cora
//
//  Created by Matheus Perez on 14/04/22.
//

import Foundation

enum CurrencyString {
    case money(value: Float)
    
    func getCurrency() -> String {
        switch self {
        case .money(let value):
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.groupingSeparator = "."
            return "R$ \(numberFormatter.string(from: NSNumber(value: value)) ?? "Valor indefinido")"
        }
    }
}
