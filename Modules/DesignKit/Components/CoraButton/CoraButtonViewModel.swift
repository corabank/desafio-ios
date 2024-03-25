//
//  CoraButtonViewModel.swift
//  DesignKit
//
//  Created by Erik Santos on 13/03/24.
//

import Foundation
import UIKit

public typealias CoraButtonSize = CoraButtonViewModel.ButtonSize
public typealias CoraAccessibleText = CoraButtonViewModel.AccessibleText
public typealias CoraButtonSideType = CoraButtonViewModel.SideType

public protocol CoraButtonViewModelProtocol {
    var sideType: CoraButtonSideType { get }
    var title: CoraAccessibleText { get }
    var icon: UIImage? { get }
    var font: UIFont? { get }
    var size: CoraButtonSize { get }
    
    init(sideType: CoraButtonSideType, title: CoraAccessibleText, icon: UIImage?, font: UIFont?, size: CoraButtonSize) 
}

public class CoraButtonViewModel: CoraButtonViewModelProtocol {
    
    // MARK: - Properties
    
    public enum SideType {
        case center
        case left
    }

    public let sideType: CoraButtonSideType
    public let title: CoraAccessibleText
    public let icon: UIImage?
    public let font: UIFont?
    public let size: CoraButtonSize
    
    // MARK: - Initialize
    
    public required init(sideType: CoraButtonSideType = .left, title: CoraAccessibleText, icon: UIImage?, font: UIFont?, size: CoraButtonSize) {
        self.sideType = sideType
        self.title = title
        self.icon = icon
        self.font = font
        self.size = size
    }
}

// MARK: - AccessibleText

extension CoraButtonViewModel {
    public struct AccessibleText {
        let text: String
        let textColor: UIColor
        let backgroundColor: UIColor
        
        public init(text: String, textColor: UIColor, backgroundColor: UIColor) {
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
        }
    }
}

// MARK: - ButtonSize

extension CoraButtonViewModel {
    public enum ButtonSize {
        case tall
        case small
        
        var value: CGFloat {
            switch self {
            case .tall:
                return 70.0
            case .small:
                return 54.0
            }
        }
    }
}
