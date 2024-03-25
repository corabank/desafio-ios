//
//  UIImage+Extension.swift
//  CoraDesafio
//
//  Created by Erik Santos on 13/03/24.
//

import Foundation
import UIKit

extension UIImage {
    
    public static func systemImage(_ text: String) -> UIImage? {
        return UIImage(systemName: text)
    }
}
