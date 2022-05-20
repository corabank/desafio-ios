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
}
