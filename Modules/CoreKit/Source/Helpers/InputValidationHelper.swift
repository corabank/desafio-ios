//
//  InputValidationHelper.swift
//  CoreKit
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation


public final class InputValidationHelper {
    
    public static let shared = InputValidationHelper()
    
    private init() {}
    
    public func validateCPF(_ cpf: String) -> Bool {
        let cpfNumerico = cpf.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard cpfNumerico.count == 11 else {
            return false
        }
        
        let cpfArray = cpfNumerico.map { Int(String($0)) ?? 0 }
        let dv1 = (0..<9).reduce(0) { total, index in total + cpfArray[index] * (10 - index) } % 11
        let dv2 = (0..<10).reduce(0) { total, index in total + cpfArray[index] * (11 - index) } % 11
        return cpfArray[9] == (dv1 < 2 ? 0 : 11 - dv1) && cpfArray[10] == (dv2 < 2 ? 0 : 11 - dv2)
    }
    
    public func validatePassword(_ password: String) -> Bool {
        return !password.isEmpty && password.count > 6
    }
}
