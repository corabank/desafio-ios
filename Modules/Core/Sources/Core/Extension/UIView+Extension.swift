//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//
import UIKit

public extension UIView {
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop = 1
        case leftToRight = 2
        case rightToLeft = 3
    }
    
    func startShimmeringAnimation(
        animationSpeed: Float = 1.4,
        direction: Direction = .leftToRight,
        repeatCount: Float = .greatestFiniteMagnitude
    ) {
        let blockView = UIView()
        blockView.tag = 987
        blockView.backgroundColor = AppColors.navigationBarBackground
        blockView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blockView)
        
        NSLayoutConstraint.activate([
            blockView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blockView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blockView.topAnchor.constraint(equalTo: topAnchor),
            blockView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: -bounds.size.height, width: 3 * bounds.size.width, height: 3 * bounds.size.height)
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        gradientLayer.locations =  [0.35, 0.50, 0.65]
        layer.mask = gradientLayer
        
        CATransaction.begin()
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        
        CATransaction.setCompletionBlock { [weak self] in
            guard let self else { return }
            self.layer.mask = nil
        }
        
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }
    
    func stopShimmeringAnimation() {
        if let blockView = subviews.first { $0.tag == 987 } {
            blockView.removeFromSuperview()
        }
        
        layer.mask = nil
    }
}
