//
//  UIImageView+withCustomImageView.swift
//  cora
//
//  Created by Lucas Silveira on 27/04/21.
//

import UIKit

extension UIImageView {
    static func customImageView(named: String = "person", tintColor: UIColor = #colorLiteral(red: 0.626042068, green: 0.6700403094, blue: 0.7117239833, alpha: 1)) -> UIImageView {
        var imageView = UIImageView()
        imageView = UIImageView(image: UIImage(named: named)?
                                        .withRenderingMode(.automatic))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
}
