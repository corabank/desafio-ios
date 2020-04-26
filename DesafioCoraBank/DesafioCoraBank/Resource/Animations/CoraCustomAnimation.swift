//
//  CoraCustomAnimation.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 25/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit
import WizardKit

class CoraCustomAnimation: UIViewControllerAnimationProtocol {
    
    private var logoImage: UIView
    
    init(logoImage: UIView) {
        self.logoImage = logoImage
    }
    
    func durationForPresenting() -> TimeInterval {
        return 1
    }
    
    func durationForDismissing() -> TimeInterval {
        return 1
    }
    
    func animatePresentationWithContext(context: UIViewControllerContextTransitioning) {
        
        let container: UIView = context.containerView
        let toVC: UIViewController = context.viewController(forKey: .to)!
        let fromVC: UIViewController = context.viewController(forKey: .from)!
        let logoPosition = logoImage.superview?.convert(logoImage.frame.origin, to: container) ?? .zero
        
        logoImage.removeFromSuperview()
        container.backgroundColor = .cbDarkBlue
        let fromScreenshot = fromVC.view.snapshotView(afterScreenUpdates: true)!
        container.addSubview(fromScreenshot)
        let toScreenshot = toVC.view.snapshotView(afterScreenUpdates: true)!
        container.addSubview(toScreenshot)

        
        container.addSubview(logoImage)
        let leadingConstraint = logoImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: logoPosition.x)
        
        let safeAreaPadding = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let topConstraint = logoImage.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: logoPosition.y - safeAreaPadding)
        let widthConstraint = logoImage.constraints.filter { $0.identifier == "width" }.first ?? logoImage.widthAnchor.constraint(equalToConstant: 50)
        let heightConstraint = logoImage.constraints.filter { $0.identifier == "height" }.first ?? logoImage.heightAnchor.constraint(equalToConstant: 50)
        leadingConstraint.isActive = true
        topConstraint.isActive = true
        widthConstraint.isActive = true
        heightConstraint.isActive = true
        container.layoutIfNeeded()
        
        toScreenshot.alpha = 0
        toScreenshot.transform = CGAffineTransform(translationX: 0, y: 100)
        
        UIView.animate(withDuration: self.durationForPresenting()/2, animations: {
            fromScreenshot.alpha = 0
            fromScreenshot.transform = CGAffineTransform(translationX: 0, y: 100)
        }) { (finished) in
            UIView.animate(withDuration: self.durationForPresenting()/2, animations: {
                toScreenshot.alpha = 1
                toScreenshot.transform = .identity
            }) { (finished) in
                fromScreenshot.removeFromSuperview()
                toScreenshot.removeFromSuperview()
                container.addSubview(toVC.view)
                context.completeTransition(finished)
            }
        }
        
        topConstraint.constant = 7.5
        leadingConstraint.constant = .cbLeftMargin
        widthConstraint.constant = 30
        heightConstraint.constant = 30
        
        UIView.animate(withDuration: self.durationForDismissing() * 0.8) {
            container.layoutIfNeeded()
        }
    }
    
    func animateDismissWithContext(context: UIViewControllerContextTransitioning) {
        let container: UIView = context.containerView
        let toVC: UIViewController = context.viewController(forKey: .to)!
        let fromVC: UIViewController = context.viewController(forKey: .from)!
        
        container.backgroundColor = .cbDarkBlue
        let fromScreenshot = fromVC.view.snapshotView(afterScreenUpdates: true)!
        container.addSubview(fromScreenshot)
        let toScreenshot = toVC.view.snapshotView(afterScreenUpdates: true)!
        container.addSubview(toScreenshot)
        
        toScreenshot.alpha = 0
        toScreenshot.transform = CGAffineTransform(translationX: 0, y: 100)
        
        UIView.animate(withDuration: self.durationForPresenting()/2, animations: {
            fromScreenshot.alpha = 0
            fromScreenshot.transform = CGAffineTransform(translationX: 0, y: 100)
        }) { (finished) in
            UIView.animate(withDuration: self.durationForPresenting()/2, animations: {
                toScreenshot.alpha = 1
                toScreenshot.transform = .identity
            }) { (finished) in
                fromScreenshot.removeFromSuperview()
                toScreenshot.removeFromSuperview()
                container.addSubview(toVC.view)
                context.completeTransition(finished)
            }
        }
    }
}

