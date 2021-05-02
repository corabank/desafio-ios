//
//  UIImageView+withCustomImageView.swift
//  cora
//
//  Created by Lucas Silveira on 27/04/21.
//

import UIKit

extension UIImageView {
    /// Custom UIImageView
    /// - Parameter name: String
    /// - Parameter tintColor: UIColor
    static func customImageView(named: String = "person.circle.fill", tintColor: UIColor = #colorLiteral(red: 0.626042068, green: 0.6700403094, blue: 0.7117239833, alpha: 1)) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: named)?
                                        .withRenderingMode(.automatic))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
}
