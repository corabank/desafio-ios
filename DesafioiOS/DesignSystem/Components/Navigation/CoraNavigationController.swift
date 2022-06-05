//
//  CoraNavigation.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

open class CoraNavigationController: UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {

        let image = Asset.chevronLeft.image
        
        let appearance = UINavigationBarAppearance()
        appearance.setBackIndicatorImage(image, transitionMaskImage: UIImage(color: .coraColor(.gray4)))
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: .coraFont(.body2), weight: .regular),
            .foregroundColor: CoraColor.gray1.color()
        ]
        
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .coraColor(.gray4)
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .coraColor(.primary)
    }
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
          let rect = CGRect(origin: .zero, size: size)
          UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
          color.setFill()
          UIRectFill(rect)
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
      
          guard let cgImage = image?.cgImage else { return nil }
          self.init(cgImage: cgImage)
    }
}


extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}
