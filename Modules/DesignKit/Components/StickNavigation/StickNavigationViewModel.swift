//
//  StickNavigationViewModel.swift
//  DesignKit
//
//  Created by Erik Santos on 13/03/24.
//

import Foundation
import UIKit

public typealias StickNavigationLeftButton = StickNavigationViewModel.LeftButton
public typealias StickNavigationTitle = StickNavigationViewModel.Title

public protocol StickNavigationViewModelProtocol: AnyObject {
    var title: StickNavigationTitle { get set }
    var leftButton: StickNavigationLeftButton? { get }
    var backgroundColor: UIColor? { get }
}

public class StickNavigationViewModel: StickNavigationViewModelProtocol {
    
    // MARK: - Properties
    
    public var title: StickNavigationTitle
    public var leftButton: StickNavigationLeftButton?
    public var backgroundColor: UIColor?
    
    public init(title: StickNavigationTitle, leftButton: StickNavigationLeftButton? = nil, backgroundColor: UIColor? = nil) {
        self.title = title
        self.leftButton = leftButton
        self.backgroundColor = backgroundColor
    }
}

// MARK: - LeftButton

extension StickNavigationViewModel {
    public struct LeftButton {
        let image: UIImage?
        let color: UIColor
        
        public init(image: UIImage?, color: UIColor) {
            self.image = image
            self.color = color
        }
    }
}

// MARK: - StickNavigationViewModel

extension StickNavigationViewModel {
    
    public struct Title {
        var text: String
        let font: UIFont?
        let color: UIColor?
        
        public init(text: String = "", font: UIFont?, color: UIColor?) {
            self.text = text
            self.font = font
            self.color = color
        }
    }
}
