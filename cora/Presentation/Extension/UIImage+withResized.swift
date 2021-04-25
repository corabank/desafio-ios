//
//  UIImage+withResized.swift
//  cora
//
//  Created by Lucas Silveira on 25/04/21.
//

import UIKit

extension UIImage {
    /**
    Function that resizes an image to a new size
    - Parameter newSize: CGSize
    - Returns: UIImage resized
    */
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
