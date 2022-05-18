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
        for ch in mask where index < newString.endIndex {
            if ch == "#" {
                result.append(newString[index])
                index = newString.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
