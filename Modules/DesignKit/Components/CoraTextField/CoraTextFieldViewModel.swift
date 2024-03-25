//
//  CoraTextFieldViewModel.swift
//  DesignKit
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation
import CoreKit
import UIKit

public typealias CoraTextFieldModel = CoraTextFieldViewModel.TextFieldModel
public typealias CoraTextFieldPasswordButton = CoraTextFieldViewModel.PasswordButton

public protocol CoraTextFieldViewModelProtocol {
    var passwordButton: CoraTextFieldPasswordButton? { get }
    var textField: CoraTextFieldModel { get }
}

public final class CoraTextFieldViewModel: CoraTextFieldViewModelProtocol {
    
    // MARK: - Properties
    
    public var textField: CoraTextFieldModel
    public var passwordButton: CoraTextFieldPasswordButton?
    
    // MARK: - Initialize
    
    public init(textField: CoraTextFieldModel, passwordButton: CoraTextFieldPasswordButton? = nil) {
        self.textField = textField
        self.passwordButton = passwordButton
    }
}

// MARK: - TextFieldModel

extension CoraTextFieldViewModel {
    
    public final class TextFieldModel {
        
        public enum TextFieldType {
            case custom
            case cpf
        }
        
        public var type: TextFieldType
        public var font: UIFont?
        public var keyboardType: UIKeyboardType
        
        public init(type: TextFieldType, font: UIFont? = nil, keyboardType: UIKeyboardType) {
            self.type = type
            self.font = font
            self.keyboardType = keyboardType
        }
    }
    
    public final class PasswordButton {
        public var hasSecure = false
        public var isShowPassword = Dynamic<Bool>(false)
        public var tintColor: UIColor
        
        public init(hasSecure: Bool = false, isShowPassword: Dynamic<Bool> = Dynamic<Bool>(false), tintColor: UIColor) {
            self.hasSecure = hasSecure
            self.isShowPassword = isShowPassword
            self.tintColor = tintColor
        }
    }
}
