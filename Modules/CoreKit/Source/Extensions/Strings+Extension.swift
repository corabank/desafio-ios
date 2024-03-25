//
//  Strings+Extension.swift
//  CoreKit
//
//  Created by Erik Santos on 23/03/24.
//

import Foundation

extension String {
    public func removeCurrencyPrefix() -> String {
        return String(self.dropFirst(3))
    }
}
