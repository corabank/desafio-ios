//
//  String.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 12/05/22.
//
import Foundation

extension String {
    func isValidCNPJ() -> Bool { // replace by a valid validator
        self.count > 16
    }

    func formatCNPJ() -> String {
        let newString = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "##.###.###/####-##"
        var result = ""
        var index = newString.startIndex
        for char in mask where index < newString.endIndex {
            if char == "#" {
                result.append(newString[index])
                index = newString.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }

    func realAmountFormatter() -> String {
        let cleanText = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard !cleanText.isEmpty else { return cleanText }
        return self.currencyInputFormatting()
    }

    private func currencyInputFormatting() -> String {
        var number = NSNumber()
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "R$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        let double = (self as NSString).doubleValue
        number = NSNumber(value: (double))

        guard number != 0 as NSNumber else {
            return ""
        }

        guard let string = formatter.string(from: number) else {
            return ""
        }
        return string
    }
}
