//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation

public extension Int {
    public var asCurrency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_BR")

        return currencyFormatter.string(from: (self / 100) as NSNumber) ?? ""
    }
}
