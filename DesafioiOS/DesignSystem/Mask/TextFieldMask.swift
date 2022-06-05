//
//  TextFieldMask.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 29/05/22.
//

import Foundation
import UIKit

// MARK: - Mask Struct
public struct Mask {
    public typealias ValidationHandler = (ValidationType) -> Bool
    public enum ValidationType {
        /// Used to validate the mask caracters on apply mask
        /// - parameters:
        /// - Character: The caracter to be added in the mask
        /// - index: The position that the carracter will be added in the mask
        case character(Character, index: Int)
        /// The complete string that will be validated
        case full(String)
    }
    
    fileprivate let validationHandler: ValidationHandler
    fileprivate static let letters = "Cc"
    public let isCaseSensitive: Bool
    public let format: String
    
    // MARK: Instance
    public init(format: String, caseSensitive: Bool = false, _ handler: ValidationHandler? = nil) {
        validationHandler = handler ?? {
            switch $0 {
            case .full(let s): return s.count == format.count
            default: return true
            }
        }
        isCaseSensitive = caseSensitive
        self.format = format
    }
    
    // MARK: Validation
    fileprivate func performValidation(for string: String) -> Bool {
        return validationHandler(.full(string))
    }
    
    // MARK: Mask Work
    fileprivate func addMask(to string: String) -> String {
        var maskedString: String, replaceCharacters = removeMask(from: string)
        
        maskedString = format.enumerated().compactMap({
            var character: String?
            
            while !replaceCharacters.isEmpty && character == nil {
                if Mask.letters.contains($0.element) {
                    let replaceCharacter = replaceCharacters.removeFirst()
                    if validationHandler(.character(replaceCharacter, index: $0.offset)) {
                        character = String(replaceCharacter)
                        if let c = character, isCaseSensitive {
                            character = "C" == $0.element ? c.uppercased() : c.lowercased()
                        }
                    }
                } else {
                    character = String($0.element)
                }
            }
            
            return character
        }).joined()
        
        return maskedString
    }
    
    fileprivate func removeMask(from string: String) -> String {
        let characters = format.compactMap({ return !Mask.letters.contains($0) ? $0 : nil })
        return String(string.compactMap({ return !characters.contains($0) ? $0 : nil }))
    }
}

// MARK: - String Extension
public extension String {
    /// Apply the given `Mask` to the current `String`
    /// - Returns: `String` with the mask applyed
    func applyMask(_ mask: Mask) -> String {
        return mask.addMask(to: self)
    }
    
    /// Validate the current `String` for the given `Mask`
    /// - Returns: `true` if the string is valid for the `Mask` Validator otherwise, `false`.
    func isValid(for mask: Mask) -> Bool {
        return mask.performValidation(for: self)
    }
    
    /// Remove all `Mask` characteres from the given `String`
    /// - Returns: `String` without the `Mask` characters
    func removeMask(_ mask: Mask) -> String {
        return mask.removeMask(from: self)
    }
}

// MARK: - TextField Extension
public extension UITextField {
    func textByReplacingCharacters(in range: NSRange, replacementString string: String) -> String? {
        return (text as NSString?)?.replacingCharacters(in: range, with: string)
    }
    
    @discardableResult
    func shouldChangeCharacters(in range: NSRange, replacementString string: String, for mask: Mask) -> Bool {
        let newText = textByReplacingCharacters(in: range, replacementString: string)?.applyMask(mask)
        let addedCharacters = string.count > 0 ? (newText?.count ?? 0) - (text?.count ?? 0) : 0
        text = newText
        
        if let newPostion = position(from: beginningOfDocument, offset: range.location + addedCharacters) {
            if let newRange = textRange(from: newPostion, to: newPostion) {
                selectedTextRange = newRange
            }
        }
        
        return false
    }
    
    func unmaskedText(for mask: Mask) -> String? {
        return text?.removeMask(mask)
    }
}
