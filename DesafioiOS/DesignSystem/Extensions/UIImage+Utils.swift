//
//  UIImage+Utils.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

extension UIImage {
    
    public func paintImage(color: CoraColor) -> UIImage? {
        var tempImage: UIImage?
        tempImage = withTintColor(.coraColor(color))
        return tempImage
    }
    
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
